# Name: WLEAPP
# Website: https://github.com/abrignoni/wleapp
# Description: Windows Logs Events and Properties Parser
# Category: Windows Analysis
# Author: Alexis Brignoni
# License: MIT License (https://github.com/abrignoni/WLEAPP/blob/main/LICENSE)
# Version: 0.1
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.packages.python3
  - cpcwin.packages.git

cpcwin-python3-wleapp-source:
  git.latest:
    - name: https://github.com/abrignoni/wleapp
    - target: '{{ inpath }}\wleapp'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

cpcwin-python3-wleapp-requirements:
  pip.installed:
    - requirements: '{{ inpath }}\wleapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: cpcwin-python3-wleapp-source
      - sls: cpcwin.packages.python3

cpcwin-python3-wleapp-header:
  file.prepend:
    - names:
      - '{{ inpath }}\wleapp\wleapp.py'
      - '{{ inpath }}\wleapp\wleappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: cpcwin-python3-wleapp-source
      - pip: cpcwin-python3-wleapp-requirements

cpcwin-python3-wleapp-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\wleapp\'

cpcwin-python3-wleapp-icon:
  file.managed:
    - name: '{{ inpath }}\abrignoni-logo.ico'
    - source: salt://cpcwin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

cpcwin-python3-wleapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\WLEAPP-GUI.lnk'
    - target: '{{ inpath }}\wleapp\wleappGUI.py'
    - force: True
    - working_dir: '{{ inpath }}\wleapp\'
    - icon_location: '{{ inpath }}\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: cpcwin-python3-wleapp-source
      - pip: cpcwin-python3-wleapp-requirements
      - file: cpcwin-python3-wleapp-header
      - win_path: cpcwin-python3-wleapp-env-vars
      - file: cpcwin-python3-wleapp-icon
