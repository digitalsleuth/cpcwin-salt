# Name: SysTools SQL MDF Viewer
# Website: https://www.systoolsgroup.com
# Description: SQL MDF Viewer
# Category: Databases
# Author: SysTools Group
# License: EULA - https://www.systoolsgroup.com/eula.pdf
# Version: 11.0
# Notes: 

mdf-viewer:
  pkg.installed

taskkill-mdf-viewer-edge-window:
  cmd.run:
    - name: 'taskkill /F /IM "msedge.exe"'
    - bg: True
    - require:
      - pkg: mdf-viewer
