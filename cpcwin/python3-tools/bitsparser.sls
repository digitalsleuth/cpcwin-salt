# Name: bitsparser
# Website: https://github.com/digitalsleuth/bitsparser
# Description: A python tool to parse Windows BITS database files
# Category: Windows Analysis
# Author: Corey Forman / FireEye
# License: Apache License v2.0 (https://github.com/digitalsleuth/BitsParser/blob/master/LICENSE)
# Version: 1.0
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}

include:
  - cpcwin.packages.git
  - cpcwin.packages.python3

bitsparser-clone:
  git.latest:
    - name: https://github.com/digitalsleuth/bitsparser
    - target: '{{ inpath }}\bitsparser'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

bitsparser-requirements:
  pip.installed:
    - requirements: '{{ inpath }}\bitsparser\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: bitsparser-clone
      - sls: cpcwin.packages.python3

bitsparser-setup:
  win_path.exists:
    - name: '{{ inpath }}\bitsparser\'
    - require:
      - pip: bitsparser-requirements
