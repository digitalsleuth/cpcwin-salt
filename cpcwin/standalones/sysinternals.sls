# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Version: 
# Notes: 

{% set hash = '8b37844a53cab67f7ee9ef2299b94169ed6894ca31e4aec08d46727fc2c99848' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

sysinternals:
  file.managed:
    - name: 'C:\salt\tempdownload\SysinternalsSuite.zip'
    - source: https://download.sysinternals.com/files/SysinternalsSuite.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

sysinternals-extract:
  archive.extracted:
    - name: 'C:\standalone\sysinternals\'
    - source: 'C:\salt\tempdownload\SysinternalsSuite.zip'
    - enforce_toplevel: false
    - require:
      - file: sysinternals

sysinternals-env-vars:
  win_path.exists:
    - name: 'C:\standalone\sysinternals'

cpcwin-standalones-sysinternals-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Sysinternals.lnk'
    - target: 'C:\standalone\sysinternals\'
    - force: True
    - working_dir: 'C:\standalone\sysinternals\'
    - makedirs: True
    - require:
      - file: sysinternals
      - archive: sysinternals-extract

cpcwin-standalones-sysinternals-nirsoft-plugin:
  file.managed:
    - name: 'C:\standalone\sysinternals\sysinternals5.nlp'
    - source: https://download.nirsoft.net/sysinternals5.nlp
    - skip_verify: True
    - makedirs: False
    - watch:
      - archive: sysinternals-extract
