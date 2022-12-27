# Name: ExifTool
# Website: https://exiftool.org
# Description: Tool for analysing EXIF data from files
# Category: Document Analysis
# Author: Phil Harvey
# License: https://exiftool.org/#license
# Version: 12.51
# Notes:

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '12.51' %}
{% set hash = 'c6081b5133a56bacd4f0e6b3117518ca0d40e994ef51040630ca2059275bad4b' %}

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
    - name: '{{ inpath }}\exiftool\EXIF_Tool.bat'
    - source: salt://cpcwin/files/EXIF_Tool.bat
    - makedirs: True

exiftool-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\exiftool\'
    - require:
      - file: exiftool-rename
