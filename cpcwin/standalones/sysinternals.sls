# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Version: 
# Notes: 

{% set hash = '399a96a0fe27a6bd21dfc775b30a1a38f834ab35af8a68d1dc7d0f2f809aa4a3' %}
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
