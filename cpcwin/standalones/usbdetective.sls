# Name: USB Detective
# Website: https://usbdetective.com
# Description: Windows USB analysis tool
# Category: Windows Analysis
# Author: Jason Hale
# License: Software License Agreement (https://usbdetective.com/docs/usbdla.pdf)
# Version: 1.6.2
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

usbdetective-download:
  file.managed:
    - name: 'C:\salt\tempdownload\USBDetective.zip'
    - source: "https://usbdetective.com/download/245/"
    - source_hash: sha256=896389F1382DC5D067AE0500FCBC0507669D9DA758D7E7A364E0618B55D2385B
    - makedirs: True

usbdetective-extract:
  archive.extracted:
    - name: '{{ inpath }}\usbdetective\'
    - source: 'C:\salt\tempdownload\USBDetective.zip'
    - enforce_toplevel: False
    - watch:
      - file: usbdetective-download

usbdetective-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\usbdetective'

cpcwin-standalones-usbdetective-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\USB Detective.lnk'
    - target: '{{ inpath }}\usbdetective\USB Detective.exe'
    - force: True
    - working_dir: '{{ inpath }}\usbdetective\'
    - makedirs: True
    - require:
      - archive: usbdetective-extract
