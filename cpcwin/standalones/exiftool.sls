# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Document Analysis
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 12.57
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '12.57' %}
{% set hash = '442112d3fc9444d8740f274bd23676d0ab75b0eb2a8e004912d5c61d59de694d' %}

exiftool-download:
  file.managed:
    - name: 'C:\salt\tempdownload\exiftool-{{ version }}.zip'
    - source: https://exiftool.org/exiftool-{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

exiftool-extract:
  archive.extracted:
    - name: '{{ inpath }}\exiftool\'
    - source: 'C:\salt\tempdownload\exiftool-{{ version }}.zip'
    - enforce_toplevel: False
    - watch:
      - file: exiftool-download

exiftool-rename:
  file.rename:
    - name: '{{ inpath }}\exiftool\exiftool.exe'
    - source: '{{ inpath }}\exiftool\exiftool(-k).exe'
    - force: True
    - require:
      - archive: exiftool-extract

exiftool-kml-fmt:
  file.managed:
    - name: '{{ inpath }}\exiftool\kml.fmt'
    - source: salt://cpcwin/files/kml.fmt
    - makedirs: True

exiftool-kml-batch:
  file.managed:
    - name: '{{ inpath }}\exiftool\exif_kml.bat'
    - source: salt://cpcwin/files/exif_kml.bat
    - makedirs: True

exiftool-kml-batch-placeholder:
  file.replace:
    - name: '{{ inpath }}\exiftool\exif_kml.bat'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: exiftool-kml-batch

exiftool-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\exiftool\'
    - require:
      - file: exiftool-rename
