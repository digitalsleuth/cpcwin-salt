# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

{% set files = ['rtfdump.py','rtf.yara'] %}

include:
  - cpcwin.packages.python3
  - cpcwin.python3-tools.yara-python

{% for file in files %}
rtfdump-download-{{ file }}:
  file.managed:
    - name: 'C:\standalone\rtfdump\{{ file }}'
    - source: https://github.com/DidierStevens/DidierStevensSuite/raw/master/{{ file }}
    - makedirs: True
    - skip_verify: True
{% endfor %}

rtfdump-header:
  file.replace:
    - name: 'C:\standalone\rtfdump\rtfdump.py'
    - pattern: '^#!/usr/bin/env python$'
    - repl: '#!/usr/bin/python3'
    - backup: False
    - prepend_if_not_found: False
    - count: 1
    - require:
      - sls: cpcwin.packages.python3
      - sls: cpcwin.python3-tools.yara-python

rtfdump-env-vars:
  win_path.exists:
    - name: 'C:\standalone\rtfdump\'

rtfdump-wrapper:
  file.managed:
    - name: 'C:\standalone\rtfdump\rtfdump.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - '"C:\Program Files\Python310\python.exe" C:\standalone\rtfdump\rtfdump.py %*'
    - require:
      - file: rtfdump-header
      - win_path: rtfdump-env-vars
