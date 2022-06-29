# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.packages.python3
  - cpcwin.packages.git
  - cpcwin.packages.ms-vcpp-2015-build-tools

cpcwin-python3-vleapp-source:
  git.latest:
    - name: https://github.com/abrignoni/vleapp
    - target: 'C:\standalone\vleapp'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

cpcwin-python3-vleapp-requirements:
  pip.installed:
    - requirements: 'C:\standalone\vleapp\requirements.txt'
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - git: cpcwin-python3-vleapp-source
      - sls: cpcwin.packages.python3
      - sls: cpcwin.packages.ms-vcpp-2015-build-tools

cpcwin-python3-vleapp-header:
  file.prepend:
    - names:
      - 'C:\standalone\vleapp\vleapp.py'
      - 'C:\standalone\vleapp\vleappGUI.py'
    - text: '#!/usr/bin/python3'
    - require:
      - git: cpcwin-python3-vleapp-source
      - pip: cpcwin-python3-vleapp-requirements

cpcwin-python3-vleapp-env-vars:
  win_path.exists:
    - name: 'C:\standalone\vleapp\'

cpcwin-python3-vleapp-icon:
  file.managed:
    - name: 'C:\standalone\abrignoni-logo.ico'
    - source: salt://cpcwin/files/abrignoni-logo.ico
    - source_hash: sha256=97ca171e939a3e4a3e51f4a66a46569ffc604ef9bb388f0aec7a8bceef943b98
    - makedirs: True

cpcwin-python3-vleapp-gui-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\VLEAPP-GUI.lnk'
    - target: 'C:\standalone\vleapp\vleappGUI.py'
    - force: True
    - working_dir: 'C:\standalone\vleapp\'
    - icon_location: 'C:\standalone\abrignoni-logo.ico'
    - makedirs: True
    - require:
      - git: cpcwin-python3-vleapp-source
      - pip: cpcwin-python3-vleapp-requirements
      - file: cpcwin-python3-vleapp-header
      - win_path: cpcwin-python3-vleapp-env-vars
      - file: cpcwin-python3-vleapp-icon
