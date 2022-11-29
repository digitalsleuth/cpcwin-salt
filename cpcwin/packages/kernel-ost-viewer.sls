# Name: Kernel OST Viewer
# Website: https://www.kerneldatarecovery.com
# Description: Outlook OST Viewer
# Category: Email
# Author: KernelApps
# License: EULA - https://www.nucleustechnologies.com/eula.pdf
# Version: 21.1
# Notes:

kernel-ost-viewer:
  pkg.installed

taskkill-ost-viewer-edge-window:
  cmd.run:
    - name: 'taskkill /F /IM "msedge.exe"'
    - bg: True
    - require:
      - pkg: kernel-ost-viewer
