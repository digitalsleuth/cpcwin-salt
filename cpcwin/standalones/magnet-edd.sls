# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes:

{% set hash = '6e0ab06b04e1d7fd2ede11d1f607422ab3f6683086c3ccf12e9ed8053d4c3796' %}
{% set version = 'v310' %}

magnet-edd-download:
  file.managed:
    - name: 'C:\salt\tempdownload\EDD{{ version }}.zip'
    - source: https://storage.googleapis.com/mfi-files/free_tools/EDD/EDD{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

magnet-edd-extract:
  archive.extracted:
    - name: 'C:\standalone\magnet\EDD\'
    - source: 'C:\salt\tempdownload\EDD{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: magnet-edd-download

