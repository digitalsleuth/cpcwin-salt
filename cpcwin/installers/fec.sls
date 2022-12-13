# Name: Forensic Email Collector
# Website: https://metaspike.com
# Description: Local and Remote email acquisition tool
# Category: Email
# Author: Arman Gungor - Metaspike
# License: 
# Version: 3.81.1.0
# Notes:

{% set version = '3.81.1.0' %}
{% set hash = '0e9346f4f49ec72fc579e499dfbd8639ce9752ba159c3e1f04056118e10534b5' %}
{% set folder_hash = 'd4af798a97ee' %}

fec-download:
  file.managed:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe'
    - source: https://storage.googleapis.com/fec-downloads/FEC/{{ version }}_{{ folder_hash }}/FECSetup_v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

fec-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\FECSetup_v{{ version }}.exe /q /norestart'
    - shell: cmd
