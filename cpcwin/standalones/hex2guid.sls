# Name: Hex2GUID
# Website: (nil - in house)
# Description: Batch script to convert hex/on-disk GUID to GUID format
# Category: Utilities
# Author: Mark Southby
# License: Free To Use
# Version: 2022050a
# Notes:

hex2guid-cmd:
  file.managed:
    - name: 'C:\standalone\hex2guid\hex2guid.cmd'
    - source: salt://cpcwin/files/HEX2GUID.cmd
    - makedirs: True

hex2guid-env-vars:
  win_path.exists:
    - name: 'C:\standalone\hex2guid\'
    - require:
      - file: hex2guid-cmd
