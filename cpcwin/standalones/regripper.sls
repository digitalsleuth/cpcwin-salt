# Name: regripper
# Website: https://github.com/keydet89/RegRipper3.0
# Description: Registry parsing toolsuite
# Category: Windows Analysis
# Author: Harlan Carvey
# License: MIT License (https://github.com/keydet89/RegRipper3.0/blob/master/license.md)
# Version: 3.0
# Notes: rr.exe

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.packages.git

cpcwin-standalones-regripper:
  git.latest:
    - name: https://github.com/keydet89/RegRipper3.0.git
    - target: 'C:\standalone\regripper'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

regripper-env-vars:
  win_path.exists:
    - name: 'C:\standalone\regripper\'

cpcwin-standalones-regripper-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\RegRipper.lnk'
    - target: 'C:\standalone\regripper\rr.exe'
    - force: True
    - working_dir: 'C:\standalone\regripper\'
    - makedirs: True
    - require:
      - git: cpcwin-standalones-regripper
