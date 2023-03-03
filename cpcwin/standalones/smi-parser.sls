# Name: smi-parser
# Website: https://github.com/digitalsleuth/smi-parser
# Description: Parses Caroolive SMI GPS files
# Category: Raw Parsers / Decoders
# Author: Corey Forman
# License: GNU General Public License v3.0 (https://github.com/digitalsleuth/smi-parser/blob/main/LICENSE)
# Version: 1.0.0
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '1.0.0' %}
{% set hash = '90bbc95e910b0d60839a764ba40820abc6fff766e9e0c315ea0534a6cb900d42' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

smi-parser-download:
  file.managed:
    - name: 'C:\standalone\smi-parser\smi-parser.exe'
    - source: https://github.com/digitalsleuth/smi-parser/releases/download/v{{ version }}/smi-parser.exe 
    - source_hash: sha256={{ hash }}
    - makedirs: True

smi-parser-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\smi-parser\'
    - require:
      - file: smi-parser-download
