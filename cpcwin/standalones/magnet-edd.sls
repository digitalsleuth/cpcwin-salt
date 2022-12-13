# Name: Encrypted Disk Detector (EDD)
# Website: https://www.magnetforensics.com
# Description: Detects encrypted disks
# Category: Utilities
# Author: Magnet Forensics
# License: EULA
# Version: 310
# Notes: Standalone Utility

{% set hash = '6e0ab06b04e1d7fd2ede11d1f607422ab3f6683086c3ccf12e9ed8053d4c3796' %}
{% set version = 'v310' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

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

magnet-edd-env-vars:
  win_path.exists:
    - name: 'C:\standalone\magnet\EDD\'

cpcwin-standalones-magnet-edd-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Magnet EDD.lnk'
    - target: 'C:\standalone\magnet\EDD\EDD{{ version }}.exe'
    - force: True
    - working_dir: 'C:\standalone\magnet\EDD\'
    - makedirs: True
    - require:
      - file: magnet-edd-download
      - archive: magnet-edd-extract
      - win_path: magnet-edd-env-vars
