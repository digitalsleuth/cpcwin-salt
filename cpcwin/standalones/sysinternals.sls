# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Version: 
# Notes: 

{% set hash = '9f39ed4f94061e7b34d72bce326e8b951a3d4b80c244e046d8dd4cb18ef58501' %}
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
