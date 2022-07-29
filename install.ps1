﻿ <#
    .SYNOPSIS
        This script is used to install the Customized CPC Windows Forensic (CPC-WIN) VM toolset into a Windows VM
        https://github.com/digitalsleuth/cpcwin-salt
    .DESCRIPTION
        The Windows Forensic VM comes with a multitude of tools for use in conducting digital forensics using a Windows
        Operating System. Many useful tools for advanced digital forensics are designed
        to run in Windows. Instead of creating a list for manual download, this installer, as well as the SaltStack state files
        which are part of the package, will allow for an easy, automated install.
        Additionally, the CPC-WIN states allow for the automated installation of the Windows Subsystem for Linux v2, and comes with
        the REMnux and SIFT toolsets, making the VM a one-stop shop for forensics!
    .NOTES
        Version        : 0.1
        Author         : Corey Forman (https://github.com/digitalsleuth)
        Prerequisites  : Windows 10 1909 or later
                       : Set-ExecutionPolicy must allow for script execution
    .PARAMETER User
        Choose the desired username to configure the installation for.
        If not selected, the currently logged in user will be selected.
    .PARAMETER Mode
        There are two modes to choose from for the installation of the CPC-WIN VM:
            addon: Install all of the tools, but don't do any customization. Leaves your config the way it is
            dedicated: Assumes that you want the full meal-deal, and will install all packages, customize the layout, and provide
                       additional reference documents
        If neither option is selected, the addon mode will be selected.
    .PARAMETER Update
        Identifies the current version of the environment and re-installs all states from that version
    .PARAMETER Upgrade
        Identifies the latest version of CPC-WIN and will install that version
    .PARAMETER Version
        Print the current version of the installed CPC-WIN environment
    .PARAMETER XUser
        The Username for the X-Ways portal - Required to download and install X-Ways
    .PARAMETER XPass
        The Password for the X-Ways portal - Required to download and install X-Ways - "QUOTES REQUIRED"
    .PARAMETER IncludeWsl
        When selected, will install the Windows Subsystem for Linux v2, and will install the SIFT and REMnux toolsets.
        This option assumes you also want the full CPC-WIN suite, and will install that first, then WSL last
    .PARAMETER WslOnly
        If you wish to install only WSLv2 with SIFT and REMnux either separately (due to bandwidth / system limitations)
        or you only want that particular feature and nothing else, this option will do just that. It will not install the CPC-WIN
        states.
    .Example
        .\install.ps1 -User forensics -Mode dedicated -IncludeWsl -XUser forensics -XPass "password123"
        .\install.ps1 -WslOnly
        .\install.ps1 -Version
        .\install.ps1 -Update
        .\install.ps1 -Upgrade
    #>

param (
  [string]$User = "",
  [string]$Mode = "",
  [string]$XUser = "",
  [string]$XPass = "",
  [switch]$Update,
  [switch]$Upgrade,
  [switch]$Version,
  [switch]$IncludeWsl,
  [switch]$WslOnly,
  [switch]$Help
)
[string]$installerVersion = 'v0.1'
[string]$saltstackVersion = '3004.1-1'
[string]$saltstackFile = 'Salt-Minion-' + $saltstackVersion + '-Py3-AMD64-Setup.exe'
[string]$saltstackHash = "C1E57767B6AB19CB1F724DB6EC2232C0DD6232A53D5CCF754CCE3AE0FB25B86F"
[string]$saltstackUrl = "https://repo.saltproject.io/windows/"
[string]$saltstackSource = $saltstackUrl + $saltstackFile
[string]$gitVersion = '2.35.1'
[string]$gitFile = 'Git-' + $gitVersion + '.2-64-bit.exe'
[string]$gitHash = "77768D0D1B01E84E8570D54264BE87194AA424EC7E527883280B9DA9761F0A2A"
[string]$gitUrl = "https://github.com/git-for-windows/git/releases/download/v" + $gitVersion + ".windows.2/" + $gitFile
[string]$versionFile = "C:\ProgramData\Salt Project\Salt\srv\salt\cpcwin-version"

function Compare-Hash($FileName, $HashName) {
    $fileHash = (Get-FileHash $FileName -Algorithm SHA256).Hash
    if ($fileHash -eq $HashName) {
        Write-Host "[+] Hashes match, continuing..." -ForegroundColor Green
    } else {
        Write-Host "[+] Hash values do not match, not continuing with install" -ForegroundColor Red
        exit
    }
}

function Test-Saltstack {
    $InstalledSalt = (Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object {$_.DisplayName -clike 'Salt Minion*' } | Select-Object DisplayName, DisplayVersion)
    if ($null -eq $InstalledSalt.DisplayName) {
        return $False
    } elseif ($InstalledSalt.DisplayName -clike 'Salt Minion*' -and $InstalledSalt.DisplayVersion -eq $saltstackVersion) {
        return $True
    }
}

function Get-Saltstack {
    if (-Not (Test-Path C:\Windows\Temp\$saltstackFile)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Write-Host "[-] Downloading SaltStack v$saltstackVersion" -ForegroundColor Yellow
        Start-BitsTransfer -Source $saltstackSource -Destination "C:\Windows\Temp\$saltstackFile"
        Write-Host "[-] Verifying Download" -ForegroundColor Yellow
        Compare-Hash -FileName C:\Windows\Temp\$saltstackFile -HashName $saltstackHash
        Write-Host "[-] Installing SaltStack v$saltstackVersion" -ForegroundColor Yellow
        Install-Saltstack
    } else {
        Write-Host "[-] Found existing SaltStack installer - validating hash before installing" -ForegroundColor Yellow
        Compare-Hash -FileName C:\Windows\Temp\$saltstackFile -HashName $saltstackHash
        Write-Host "[+] Installing SaltStack v$saltstackVersion" -ForegroundColor Yellow
        Install-Saltstack
    }
}

function Install-Saltstack {
    Start-Process -Wait -FilePath "C:\Windows\Temp\$saltstackFile" -ArgumentList '/S /master=localhost /minion-name=CPC-WIN' -PassThru | Out-Null
    if ($?) {
        Write-Host "[+] SaltStack installed successfully" -ForegroundColor Green
    } else {
        Write-Host "[!] Installation of SaltStack failed. Please re-run the installer to try again" -ForegroundColor Red
        exit
    }
}

function Test-Git {
    $InstalledGit = (Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' | Where-Object {$_.DisplayName -clike 'Git*' } | Select-Object DisplayName, DisplayVersion)
    if ($null -eq $InstalledGit.DisplayName) {
        return $False
    } elseif ($InstalledGit.DisplayName -clike 'Git*' -and $InstalledGit.DisplayVersion -clike "$gitVersion*") {
        return $True
    }
}

function Get-Git {
    if (-Not (Test-Path C:\Windows\Temp\$gitFile)) {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Write-Host "[-] Downloading Git v$gitVersion" -ForegroundColor Yellow
        Start-BitsTransfer -Source $gitUrl -Destination "C:\Windows\Temp\$gitFile"
        Write-Host "[-] Verifying Download" -ForegroundColor Yellow
        Compare-Hash -FileName C:\Windows\Temp\$gitFile -HashName $gitHash
        Write-Host "[-] Installing Git v$gitVersion" -ForegroundColor Yellow
        Install-Git
    } else {
        Write-Host "[-] Found existing Git installer - validating hash before installing" -ForegroundColor Yellow
        Compare-Hash  -FileName C:\Windows\Temp\$gitFile -HashName $gitHash
        Write-Host "[-] Installing Git v$gitVersion" -ForegroundColor Yellow
        Install-Git
    }
}

function Install-Git {
    Start-Process -Wait -FilePath "C:\Windows\Temp\$gitFile" -ArgumentList '/VERYSILENT /NORESTART /SP- /NOCANCEL /SUPPRESSMSGBOXES' -PassThru | Out-Null
    if ($?) {
        Write-Host "[+] Git installed successfully" -ForegroundColor Green
    } else {
        Write-Host "[!] Installation of Git failed. Please re-run the installer to try again" -ForegroundColor Red
        exit
    }
}
function Get-CPCWINRelease($installVersion) {
    $zipFolder = 'CPCWIN-salt-' + $installVersion.Split("v")[-1]
    Write-Host "[-] Downloading and unpacking $installVersion" -ForegroundColor Yellow
    Start-BitsTransfer -Source https://github.com/digitalsleuth/cpcwin-salt/archive/refs/tags/$installVersion.zip -Destination C:\Windows\Temp
    Start-BitsTransfer -Source https://github.com/digitalsleuth/cpcwin-salt/releases/download/$installVersion/cpcwin-salt-$installVersion.zip.sha256 -Destination C:\Windows\Temp
    $releaseHash = (Get-Content C:\Windows\Temp\cpcwin-salt-$installVersion.zip.sha256).Split(" ")[0]
    Write-Host "[-] Validating hash for release file" -ForegroundColor Yellow
    Compare-Hash -FileName C:\Windows\Temp\$installVersion.zip -HashName $releaseHash
    Expand-Archive -Path C:\Windows\Temp\$installVersion.zip -Destination 'C:\ProgramData\Salt Project\Salt\srv\' -Force
    if (Test-Path "C:\ProgramData\Salt Project\Salt\srv\salt") {
        Remove-Item -Force "C:\ProgramData\Salt Project\Salt\srv\salt" -Recurse
    }
    Move-Item "C:\ProgramData\Salt Project\Salt\srv\$zipFolder" 'C:\ProgramData\Salt Project\Salt\srv\salt' -Force
}

function Install-CPCWIN {
    $apiUri = "https://api.github.com/repos/digitalsleuth/cpcwin-salt/releases/latest"
    $latestVersion = ((((Invoke-WebRequest $apiUri -UseBasicParsing).Content) | ConvertFrom-Json).zipball_url).Split('/')[-1]
    $installVersion = $latestVersion
    if ($Update) {
       if(-Not (Test-Path $versionFile)) {
           $cpcwinVersion = 'not installed'
           Write-Host "[!] CPC-WIN is not installed. Try running the installer again before choosing the update option." -ForegroundColor Red
           exit
        } else {
           $cpcwinVersion = (Get-Content $versionFile)
        }
        $installVersion = $cpcwinVersion
	} elseif ($Upgrade) {
        if(-Not (Test-Path $versionFile)) {
           $cpcwinVersion = 'not installed'
           Write-Host "[!] CPC-WIN is not installed. Try running the installer again before choosing the upgrade option." -ForegroundColor Red
           exit
       } else {
        $installVersion = $latestVersion
        }
    }
    $saltStatus = Test-Saltstack
    if ($saltStatus -eq $False) {
        Write-Host "[-] SaltStack not installed" -ForegroundColor Yellow
        Get-Saltstack
    } elseif ($saltStatus -eq $True) {
        Write-Host "[+] SaltStack v$saltstackVersion already installed" -ForegroundColor Green
    }
	$gitStatus = Test-Git
    if ($gitStatus -eq $False) {
        Write-Host "[-] Git not installed" -ForegroundColor Yellow
        Get-Git
    } elseif ($gitStatus -eq $True) {
        Write-Host "[+] Git v$gitVersion already installed" -ForegroundColor Green
    }
    Write-Host "[-] Refreshing environment variables" -ForegroundColor Yellow
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
    $logFile = "C:\cpcwin-saltstack-$installVersion.log"
    Get-CPCWINRelease $installVersion
    if (($XUser -ne "") -and ($XPass -ne "")) {
        $AuthToken = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($XUser + ":" + $XPass))
        ((Get-Content 'C:\ProgramData\Salt Project\Salt\srv\salt\cpcwin\standalones\x-ways.sls') -replace ' = "TOKENPLACEHOLDER"', (" = "+ '"' + $AuthToken + '"')) | Set-Content 'C:\ProgramData\Salt Project\Salt\srv\salt\cpcwin\standalones\x-ways.sls'
        }
    Write-Host "[+] The CPC-WIN installer command is running, configuring for user $User - this will take a while... please be patient" -ForegroundColor Green
    Start-Process -Wait -FilePath "C:\Program Files\Salt Project\Salt\salt-call.bat" -ArgumentList ("-l debug --local --retcode-passthrough --state-output=mixed state.sls cpcwin.$Mode pillar=`"{'cpcwin_user': '$User'}`" --log-file-level=debug --log-file=`"$logFile`" --out-file=`"$logFile`" --out-file-append") | Out-Null
    if (-Not (Test-Path $logFile)) {
        $results=$failures=$errors=$null
	} else {
    $results = (Select-String -Path $logFile -Pattern 'Succeeded:' -Context 1 | ForEach-Object{"[!] " + $_.Line; "[!] " + $_.Context.PostContext} | Out-String).Trim()
    $failures = (Select-String -Path $logFile -Pattern 'Succeeded:' -Context 1 | ForEach-Object{$_.Context.PostContext}).split(':')[1].Trim()
    $errors = (Select-String -Path $logFile -Pattern '          ID:' -Context 0,6 | ForEach-Object{$_.Line; $_.Context.DisplayPostContext + "`r-------------"})
    }
	$errorLogFile = "C:\cpcwin-errors-$installVersion.log"
    if ($failures -ne 0 -and $null -ne $failures) {
        $errors | Out-File $errorLogFile -Append
        Write-Host $results -ForegroundColor Yellow
        Write-Host "[!] To determine the cause of the failures, review the log file $logFile and search for lines containing [ERROR   ] or review $errorLogFile for a less verbose listing." -ForegroundColor Yellow
        Write-Host "[!] In order to ensure all configuration changes are successful, it is recommended to reboot before first use." -ForegroundColor Yellow
    } else {
        Write-Host $results -ForegroundColor Green
        Write-Host "[!] In order to ensure all configuration changes are successful, it is recommended to reboot before first use." -ForegroundColor Green
    }
    if ($IncludeWsl) {
        if ($results) {
            $results | Out-File "C:\cpcwin-results-$installVersion.log" -Append
            }
        Invoke-WSLInstaller
    }
}

function Invoke-CPCWINInstaller {
    $runningUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-Not $runningUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "[!] Not running as administrator, please re-run this script as Administrator" -ForegroundColor Red
        exit 1
    }
    if ($User -eq "") {
        $User = [System.Environment]::UserName
        }
    if ($Mode -eq "") {
        $Mode = "addon"
        }
    if (($Mode -ne 'addon') -and ($Mode -ne 'dedicated')) {
        Write-Host "[!] The only valid modes are 'addon' or 'dedicated'." -ForegroundColor Red
        exit 1
    }
    Write-Host "[-] Running CPC-WIN SaltStack installation" -ForegroundColor Yellow
    Install-CPCWIN
}

function Invoke-WSLInstaller {
    if ($User -eq "") {
        $User = [System.Environment]::UserName
    }
    $runningUser = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if (-not $runningUser.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "[!] Not running as administrator, please re-run this script as Administrator" -ForegroundColor Red
        exit 1
    }
    ### UAC and Defender settings based on https://github.com/Disassembler0/Win10-Initial-Setup-Script
    ### Required for unattended WSL setup
    Write-Output "[-] Lowering UAC level..."
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
    If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
    }
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
	If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
	    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
	} ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
        Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
    }
    Add-MpPreference -ExclusionPath "C:\standalone\wsl"
    $wslLogFile = "C:\cpcwin-wsl.log"
    $wslErrorLog = "C:\cpcwin-wsl-errors.log"
    if (-Not (Test-Path "C:\ProgramData\Salt Project\Salt\srv\salt\cpcwin")) {
        $apiUri = "https://api.github.com/repos/digitalsleuth/cpcwin-salt/releases/latest"
        $latestVersion = ((((Invoke-WebRequest $apiUri -UseBasicParsing).Content) | ConvertFrom-Json).zipball_url).Split('/')[-1]
        $installVersion = $latestVersion
        Get-CPCWINRelease $installVersion
    }
    Write-Host "[+] Preparing for WSLv2 Installation" -ForegroundColor Green
    Write-Host "[!] This will process will automatically reboot the system and continue on the next login" -ForegroundColor Yellow
    Start-Process -Wait -FilePath "C:\Program Files\Salt Project\Salt\salt-call.bat" -ArgumentList ("-l debug --local --retcode-passthrough --state-output=mixed state.sls cpcwin.repos pillar=`"{'cpcwin_user': '$User'}`" --log-file-level=debug --log-file=`"$wslLogFile`" --out-file=`"$wslLogFile`" --out-file-append") | Out-Null
    Start-Process -Wait -FilePath "C:\Program Files\Salt Project\Salt\salt-call.bat" -ArgumentList ("-l debug --local --retcode-passthrough --state-output=mixed state.sls cpcwin.wsl pillar=`"{'cpcwin_user': '$User'}`" --log-file-level=debug --log-file=`"$wslLogFile`" --out-file=`"$wslLogFile`" --out-file-append") | Out-Null
    ### If the above is successful, the following lines have no effect, as a reboot will have occurred.
    ### However, if they are not successful, the following will log the errors in a separate file for examination.
    $wslErrors = (Select-String -Path $wslLogFile -Pattern '          ID:' -Context 0,6 | ForEach-Object{$_.Line; $_.Context.DisplayPostContext + "`r-------------"})
    if ($wslErrors -ne 0 -and $null -ne $wslErrors) {
        $wslErrors | Out-File $wslErrorLog -Append
    }
}

function Show-CPCWINHelp {
    Write-Host -ForegroundColor Yellow @"
Windows Forensics VM (CPC-WIN) Installer $installerVersion
Usage:
    -User <user>  Choose the desired username for which to configure the installation
    -Mode <mode>  There are two modes to choose from for the installation:
                  addon: Install all of the tools, but don't do any customization
                  dedicated: Assumes you want the full meal-deal, will install all packages and customization
    -Update       Identifies the current version of CPC-WIN and re-installs all states from that version
    -Upgrade      Identifies the latest version of CPC-WIN and will install that version
    -Version      Displays the current version of CPC-WIN (if installed) then exits
    -XUser        The Username for the X-Ways portal - Required to download and install X-Ways
    -XPass        The Password for the X-Ways portal - Required to download and install X-Ways - QUOTES REQUIRED
    -IncludeWsl   Will install the Windows Subsystem for Linux v2 with SIFT and REMnux toolsets
                  This option assumes you also want the full CPC-WIN suite, install that first, then WSL
    -WslOnly      If you wish to only install WSLv2 with SIFT and REMnux separately, without the tools
"@
}

function Get-CPCWINVersion {
    if(-Not (Test-Path $versionFile)) {
        $cpcwinVersion = 'not installed'
    } else {
        $cpcwinVersion = (Get-Content $versionFile)
    }
    Write-Host "CPC-WIN is $cpcwinVersion" -ForegroundColor Green
    exit
}

if ($WslOnly) {
    $saltStatus = Test-Saltstack
    $gitStatus = Test-Git
    if ($saltStatus -ne $True) {
        Write-Host "[-] SaltStack not installed" -ForegroundColor Yellow
        Get-Saltstack
    }
    if ($gitStatus -ne $True) {
        Write-Host "[-] Git not installed" -ForegroundColor Yellow
        Get-Git
    }
    Invoke-WSLInstaller
} elseif ($Help -and $PSBoundParameters.Count -eq 1) {
    Show-CPCWINHelp
} elseif ($Version -and $PSBoundParameters.Count -eq 1) {
    Get-CPCWINVersion
} elseif ($PSBoundParameters.Count -eq 0) {
    Invoke-CPCWINInstaller
} else {
    Invoke-CPCWINInstaller
}
