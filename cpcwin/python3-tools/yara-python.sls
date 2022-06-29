# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - cpcwin.packages.ms-vcpp-2015-build-tools

yara-python:
  pip.installed:
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: cpcwin.packages.ms-vcpp-2015-build-tools
