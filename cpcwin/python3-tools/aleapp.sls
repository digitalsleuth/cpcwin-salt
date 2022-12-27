# Name: ALEAPP
# Website: https://github.com/abrignoni/aleapp
# Description: Android Logs Events and Protobuf Parser
# Category: Mobile Analysis
# Author: Alexis Brignoni
# License: MIT License (https://github.com/abrignoni/ALEAPP/blob/master/LICENSE)
# Version: 3.1.1
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.packages.python3
  - cpcwin.packages.git

cpcwin-python3-aleapp-source:
  git.latest:
    - name: https://github.com/abrignoni/aleapp
    - target: '{{ inpath }}\aleapp'
    - rev: master
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

cpcwin-python3-aleapp-requirements:
  pip.installed:
    - requirements: '{{ inpath }}\aleapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: cpcwin-python3-aleapp-source
      - sls: cpcwin.packages.python3

cpcwin-python3-aleapp-header:
  file.prepend:
    - names:
      - '{{ inpath }}\aleapp\aleapp.py'
      - '{{ inpath }}\aleapp\aleappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: cpcwin-python3-aleapp-source
      - pip: cpcwin-python3-aleapp-requirements

cpcwin-python3-aleapp-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\aleapp\'

cpcwin-python3-aleapp-icon:
  file.managed:
    - name: '{{ inpath }}\abrignoni-logo.ico'
    - source: salt://cpcwin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

cpcwin-python3-aleapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\ALEAPP-GUI.lnk'
    - target: '{{ inpath }}\aleapp\aleappGUI.py'
    - force: True
    - working_dir: '{{ inpath }}\aleapp\'
    - icon_location: '{{ inpath }}\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: cpcwin-python3-aleapp-source
      - pip: cpcwin-python3-aleapp-requirements
      - file: cpcwin-python3-aleapp-header
      - win_path: cpcwin-python3-aleapp-env-vars
      - file: cpcwin-python3-aleapp-icon
