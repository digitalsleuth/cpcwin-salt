# Name: Forensic Email Collector
# Website: https://metaspike.com
# Description: Local and Remote email acquisition tool
# Category: Email
# Author: Arman Gungor - Metaspike
# License: 
# Version: 3.75.1.12
# Notes:

{% set version = '3.75.1.12' %}
{% set hash = '02F62A581B9F972834E403136EBAFEE145549F9B8B88F70F592ABE4742128D80' %}
{% set folder_hash = 'f9966d48eeaa' %}

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
