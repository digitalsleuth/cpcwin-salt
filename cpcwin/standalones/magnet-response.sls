# Name: Magnet RESPONSE
# Website: https://magnetforensics.com
# Description: Tool to collect data relevant to incident response investigations
# Category: Acquisition and Analysis
# Author: Magnet Forensics
# License: EULA
# Version: 1.6
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = 'c63420bd241972280fa51d7b0b9966c9016eb6e462aacb4ab3754d458a33f3e7' %}
{% set version = '160' %}

magnet-response-download:
  file.managed:
    - name: 'C:\salt\tempdownload\MagnetRESPONSEv{{ version }}.zip'
    - source: https://storage.googleapis.com/mfi-files/free_tools/MagnetRESPONSE/MagnetRESPONSEv{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

magnet-response-extract:
  archive.extracted:
    - name: '{{ inpath }}\magnet\Response\'
    - source: 'C:\salt\tempdownload\MagnetRESPONSEv{{ version }}.zip'
    - enforce_toplevel: False
    - require:
      - file: magnet-response-download
      
