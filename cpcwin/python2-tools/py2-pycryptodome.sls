# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - cpcwin.packages.vcforpython27

py2-pycryptodome:
  pip.installed:
    - name: 'pycryptodome'
    - bin_env: 'C:\Python27\python.exe'
    - require:
      - sls: cpcwin.packages.vcforpython27
