# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - cpcwin.packages.python3

iptools-download:
  file.managed:
    - name: 'C:\Program Files\Python310\Scripts\iptools.py'
    - source: https://github.com/digitalsleuth/forensics_tools/raw/master/iptools.py
    - source_hash: sha256=de771ec7c7748fa8a47581e5dc40b3490de62e82482a85dff39f8246ce220b89
    - makedirs: True
    - require:
      - sls: cpcwin.packages.python3
