# Name: evtx_dump
# Website: https://github.com/omerbenamram/evtx
# Description: EVTX Event Log Parser
# Category: Log Parsers
# Author: Omer BenAmram
# License: Apache License v2 (https://github.com/omerbenamram/evtx/blob/master/LICENSE-APACHE) and MIT License (https://github.com/omerbenamram/evtx/blob/master/LICENSE-MIT)
# Version: 0.8.0
# Notes: 

{% set version = '0.8.0' %}
{% set hash = '152d3d0c4cd43e1d61f9e6b7c0ad58330317c460ab1745952ffd73f2f0a58262' %}

evtx-dump:
  file.managed:
    - name: 'C:\standalone\evtx-dump\evtx_dump.exe'
    - source: https://github.com/omerbenamram/evtx/releases/download/v{{ version }}/evtx_dump-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - replace: True

evtx-dump-env-vars:
  win_path.exists:
    - name: 'C:\standalone\evtx-dump\'
