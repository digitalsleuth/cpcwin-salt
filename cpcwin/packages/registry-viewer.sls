# Name: AccessData Registry Viewer
# Website: https://www.exterro.com
# Description: Registry Analysis Tool
# Category: Windows Analysis
# Author: AccessData / Exterro
# License: EULA
# Version: 2.0.0.7
# Notes: 

registry-viewer:
  pkg.installed

registry-viewer-del-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Registry Viewer.lnk'
    - require:
      - pkg: registry-viewer
