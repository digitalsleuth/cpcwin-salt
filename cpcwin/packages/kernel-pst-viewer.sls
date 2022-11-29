# Name: Kernel PST Viewer
# Website: https://www.kerneldatarecovery.com
# Description: Outlook PST Parser
# Category: Email
# Author: KernelApps
# License: EULA - https://www.nucleustechnologies.com/eula.pdf
# Version: 20.3
# Notes:

kernel-pst-viewer:
  pkg.installed

taskkill-pst-viewer-edge-window:
  cmd.run:
    - name: 'taskkill /F /IM "msedge.exe"'
    - bg: True
    - require:
      - pkg: kernel-pst-viewer
