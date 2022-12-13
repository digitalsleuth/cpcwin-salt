# Name: XLMMacroDeobfuscator
# Website: https://github.com/DissectMalware/XLMMacroDeobfuscator
# Description: Decode obfuscated XLM macros (aka Excel v4.0 macros)
# Category: Document Analysis
# Author: Malwrologist / DissectMalware
# License: Apache License v2.0 (https://github.com/DissectMalware/XLMMacroDeobfuscator/blob/master/LICENSE)
# Version: 0.2.7
# Notes: 

include:
  - cpcwin.packages.python3

XLMMacroDeobfuscator:
  pip.installed:
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - sls: cpcwin.packages.python3
