# Name: WSL 2 System Update
# Website: https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
# Description: Update for Windows Subsystem for Linux to version 2
# Category: Requirements
# Author: Microsoft
# License: EULA
# Version: 5.10.16
# Notes: 

include:
  - cpcwin.repos

wsl2-update:
  pkg.installed:
    - require:
      - sls: cpcwin.repos
