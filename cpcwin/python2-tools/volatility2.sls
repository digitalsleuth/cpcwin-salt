# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

include:
  - cpcwin.packages.python2
  - cpcwin.python2-tools.py2-pycryptodome
  - cpcwin.python2-tools.distorm3

volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility
    - bin_env: 'C:\Python27\python.exe'
    - require:
      - sls: cpcwin.packages.python2
      - sls: cpcwin.python2-tools.py2-pycryptodome
      - sls: cpcwin.python2-tools.distorm3

volatility2-wrapper:
  file.managed:
    - name: 'C:\Python27\Scripts\vol2.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'C:\Python27\python.exe C:\Python27\Scripts\vol.py %*'

volatility2-env-vars:
  win_path.exists:
    - name: 'C:\Python27\Scripts\'
