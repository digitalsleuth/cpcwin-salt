# Name: The Sleuth Kit
# Website: https://github.com/sleuthkit/sleuthkit/
# Description: Library and collection of command line DFIR tools
# Category: Windows Analysis
# Author: Brian Carrier
# License: Multiple Licenses (https://www.sleuthkit.org/sleuthkit/licenses.php)
# Version: 4.11.1
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '4.11.1' %}
{% set hash = '30636e722be838e8fc5c93e6dd29f2a3ebf7e88c775aa70b96fc4c6f48ac64d5' %}

include:
  - cpcwin.packages.strawberryperl

sleuthkit-download:
  file.managed:
    - name: 'C:\salt\tempdownload\sleuthkit-{{ version }}-win32.zip'
    - source: https://github.com/sleuthkit/sleuthkit/releases/download/sleuthkit-{{ version }}/sleuthkit-{{ version }}-win32.zip
    - source_hash: {{ hash }}
    - makedirs: True

sleuthkit-extract:
  archive.extracted:
    - name: 'C:\salt\tempdownload\'
    - source: 'C:\salt\tempdownload\sleuthkit-{{ version }}-win32.zip'
    - enforce_toplevel: False
    - require:
      - file: sleuthkit-download
      - sls: cpcwin.packages.strawberryperl

sleuthkit-folder-rename:
  file.rename:
    - name: '{{ inpath }}\sleuthkit'
    - source: 'C:\salt\tempdownload\sleuthkit-{{ version }}-win32\'
    - force: True
    - makedirs: True
    - require:
      - archive: sleuthkit-extract

sleuthkit-mactime-wrapper:
  file.managed:
    - name: '{{ inpath }}\sleuthkit\bin\mactime.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - perl {{ inpath }}\sleuthkit\bin\mactime.pl %*

'{{ inpath }}\sleuthkit\bin':
  win_path.exists
