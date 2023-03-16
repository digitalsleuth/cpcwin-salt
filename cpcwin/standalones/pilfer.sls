# Name: Pilfer
# Website: https://github.com/digitalsleuth/forensics_tools
# Description: Rapid triage tool using Windows in-built binaries
# Category: Acquisition and Analysis
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3 (https://github.com/digitalsleuth/forensics_tools/blob/master/LICENSE)
# Version: 2.4
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set hash = '60fcc8bc76846692d105f4c996552d1ca7d497393c90df69c5f7b2106242ae73' %}

pilfer-download:
  file.managed:
    - name: '{{ inpath }}\pilfer\pilfer.bat'
    - source: https://github.com/digitalsleuth/forensics_tools/raw/master/pilfer.bat
    - source_hash: sha256={{ hash }}
    - makedirs: True

pilfer-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\pilfer\'
    - require:
      - file: pilfer-download
