# Name: VcXsrv Windows X Server
# Website: https://sourceforge.net/projects/vcxsrv/
# Description: Windows X-Server
# Category: Utilities
# Author: Marha
# License: GNU General Public License v3
# Version: 1.20.14.0
# Notes: 

vcxsrv:
  pkg.installed

vcxsrv-del-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\XLaunch.lnk'
    - require:
      - pkg: vcxsrv
