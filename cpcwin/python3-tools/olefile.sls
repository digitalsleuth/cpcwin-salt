# Name: olefile
# Website: https://www.decalage.info/python/olefileio
# Description: Python module to read / write MS OLE2 files
# Category: Document Analysis
# Author: Philippe Lagadec
# License: https://github.com/decalage2/olefile/blob/master/LICENSE.txt
# Version: 0.46
# Notes: 

include:
  - cpcwin.packages.python3

olefile:
  pip.installed:
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: cpcwin.packages.python3
