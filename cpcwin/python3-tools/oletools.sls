# Name: oletools
# Website: http://www.decalage.info/python/oletools
# Description: Package of tools to analyze MS OLE2 files
# Category: Document Analysis
# Author: Philippe Lagadec
# License: https://github.com/decalage2/oletools/blob/master/LICENSE.md
# Version: 0.60.1
# Notes: 

include:
  - cpcwin.packages.python3

oletools:
  pip.installed:
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: cpcwin.packages.python3
