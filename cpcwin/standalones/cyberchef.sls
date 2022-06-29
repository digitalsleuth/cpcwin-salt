# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

{% set version = '9.32.3' %}
{% set hash = '465cf64bdd80cf99be72bedc9dccf7fcebaeace58d77ec62d71733c3e2ba404f' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.packages.firefox

cpcwin-standalones-cyberchef:
  archive.extracted:
    - name: 'C:\standalone\cyberchef'
    - enforce_toplevel: False
    - source: https://github.com/gchq/CyberChef/releases/download/v{{ version}}/CyberChef_v{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - overwrite: True
    - require:
      - sls: cpcwin.packages.firefox

cpcwin-standalones-cyberchef-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\CyberChef.lnk'
    - target: 'C:\Program Files\Mozilla Firefox\firefox.exe'
    - arguments: 'C:\standalone\cyberchef\CyberChef_v{{ version }}.html'
    - force: True
    - working_dir: 'C:\Program Files\Mozilla Firefox'
    - makedirs: True
    - require:
      - sls: cpcwin.packages.firefox
      - archive: cpcwin-standalones-cyberchef
