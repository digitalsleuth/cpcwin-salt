# Name:
# Website:
# Description:
# Category:
# Author:
# License:
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
