# CPC-WIN Salt States
Customized CPC Windows Forensics VM Salt States

The design behind this is to use a barebones Windows 10 VM (preferably 1909 and higher to support WSLv2).
Once configured, and activated (to support customization features), then you can use the install.ps1 file to
install all of the packages.

The install requires that the `Set-ExecutionPolicy` feature be set to allow the script to run, at least twice, depending on your choices.
This is best left to you to decide what is acceptable in your organization.

## Usage
```text
Usage:
  .\install.ps1 -User <user> -Mode <mode> -IncludeWsl -WslOnly -Update -Upgrade
  .\install.ps1 -Version
  .\install.ps1 -Help

Options:
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
    -Help         Self-explanatory
```

## Issues

All issues should be raised at the [CPC-WIN Salt Repo](https://github.com/digitalsleuth/cpcwin-salt)

## What the install.ps1 does

Installs [Saltstack 3004.1](https://repo.saltproject.io/windows/Salt-Minion-3004.1-1-Py3-AMD64-Setup.exe) then installs 
[Git](https://git-scm.com/download/win), then runs the following commands:
```
git clone https://github.com/digitalsleuth/cpcwin-salt/ "C:\ProgramData\Salt Project\Salt\srv\salt"
salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls cpcwin.$mode pillar="{'cpcwin_user': '$user'}" --log-file="C:\cpcwin-saltstack.log" --log-file-level=debug --out-file="C:\cpcwin-saltstack.log" --out-file-append
```
