# Name: Magnet RESPONSE
# Website: https://magnetforensics.com
# Description: Tool to collect data relevant to incident response investigations
# Category: Acquisition and Analysis
# Author: Magnet Forensics
# License: EULA
# Version: 1.61
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '6b1673685aee0a65c5cc0bd5f0e0e741e781cf28115abca3dcc92cca287736b8' %}
{% set version = '161' %}

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
      
