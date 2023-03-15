# Name: msoffcrypto-tool
# Website: https://github.com/nolze/msoffcrypto-tool
# Description: Python library for decrypting encrypted MS Office Files
# Category: Document Analysis
# Author: Nolze
# License: MIT License (https://github.com/nolze/msoffcrypto-tool/blob/master/LICENSE.txt)
# Version: 5.0.0
# Notes: 

include:
  - cpcwin.packages.python3

msoffcrypto-tool:
  pip.installed:
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: cpcwin.packages.python3
