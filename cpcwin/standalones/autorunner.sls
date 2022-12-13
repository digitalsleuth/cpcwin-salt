# Name: Autorunner
# Website: https://github.com/woanware/autorunner
# Description: Checks for autorun applications on Windows
# Category: Windows Analysis
# Author: Mark Woan
# License: Public Domain
# Version: 0.0.16
# Notes: 

{% set version = '0.0.16' %}
{% set hash = 'ad4cdf61cf7e2ab77e78cc425788e526d02e2149ea1965bf870c0558700c77eb' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.standalones.sysinternals

autorunner-download:
  file.managed:
    - name: 'C:\salt\tempdownload\autorunner.v{{ version }}.zip'
    - source: https://github.com/woanware/autorunner/releases/download/v{{ version }}/autorunner.v{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

autorunner-extracted:
  archive.extracted:
    - name: 'C:\standalone\autorunner\'
    - source: 'C:\salt\tempdownload\autorunner.v{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: autorunner-download
      - sls: cpcwin.standalones.sysinternals

autorunner-config-1:
  file.directory:
    - name: 'C:\standalone\autorunner\Tools'
    - win_inheritance: True
    - makedirs: True
    - require:
      - archive: autorunner-extracted

autorunner-config-2:
  file.symlink:
    - name: 'C:\standalone\autorunner\Tools\sigcheck.exe'
    - target: 'C:\standalone\sysinternals\sigcheck.exe'
    - force: True
    - makedirs: True
    - win_inheritance: True
    - require:
      - file: autorunner-config-1

autorunner-env-vars:
  win_path.exists:
    - name: 'C:\standalone\autorunner\'
    - require:
      - file: autorunner-config-2

cpcwin-standalones-autorunner-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\AutoRunner.lnk'
    - target: 'C:\standalone\autorunner\autorunner.exe'
    - force: True
    - working_dir: 'C:\standalone\autorunner\'
    - makedirs: True
    - require:
      - archive: autorunner-extracted
