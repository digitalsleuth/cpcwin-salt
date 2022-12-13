# CPC-WIN Salt States
Customized CPC Windows Forensics Environment Salt States

The design behind this is to use a barebones Windows 10 VM or machine (preferably 1909 and higher to support WSLv2).
Once configured, and activated (to support customization features), then you can use the installer to
install all of the packages.

To use the cpcwin-cli.exe standalone installer, only an Administrator Command Prompt is required.  
To prep your environment prior to using the PowerShell installer, make sure you launch a PowerShell Prompt as Administrator and run the following command:

```powershell
Set-ExecutionPolicy Bypass -Force
```

Once you've run that, change to the directory where you've downloaded the installer. Running the installer with the -Help argument will present you the options below.
  
## Usage  
```markup
Usage (cpcwin-cli.ps1 or cpcwin-cli.exe):
    cpcwin-cli -Install
    cpcwin-cli -Install -User <user> -Mode <mode> -IncludeWsl
    cpcwin-cli -WslOnly
    cpcwin-cli -Update
    cpcwin-cli -Upgrade
    cpcwin-cli -Version
    cpcwin-cli -Help

Options:
    -Install      Installs the CPC-WIN environment
    -User <user>  Choose the desired username for which to configure the installation
    -Mode <mode>  There are two modes to choose from for the installation:
                  addon: Install all of the tools, but don't do any customization
                  dedicated: Assumes you want the full meal-deal, will install all packages and customization
    -Update       Identifies the current version of CPC-WIN and re-installs all states from that version
    -Upgrade      Identifies the latest version of CPC-WIN and will install that version
    -Version      Displays the current version of CPC-WIN (if installed) then exits
    -XUser        The Username for the X-Ways portal - Required to download and install X-Ways
    -XPass        The Password for the X-Ways portal - Required to download and install X-Ways - USE QUOTES
    -IncludeWsl   Will install the Windows Subsystem for Linux v2 with SIFT and REMnux toolsets
                  This option assumes you also want the full CPC-WIN suite, install that first, then WSL
    -WslOnly      If you wish to only install WSLv2 with SIFT and REMnux separately, without the tools
    -Help         Self-explanatory
```  

## Issues

All issues should be raised under the [Issues section](https://github.com/digitalsleuth/cpcwin-salt/issues).
