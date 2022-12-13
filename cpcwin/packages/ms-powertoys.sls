# Name: Microsoft PowerToys
# Website: https://github.com/microsoft/powertoys
# Description: Windows productivity system utilities
# Category: Utilities
# Author: Microsoft
# License: MIT (https://github.com/microsoft/PowerToys/blob/main/LICENSE)
# Version: 0.64.1
# Notes:

ms-powertoys:
  pkg.installed

taskkill-powertoys-settings-window:
  cmd.run:
    - name: 'taskkill /F /IM "PowerToys.Settings.exe"'
    - bg: True
    - require:
      - pkg: ms-powertoys
