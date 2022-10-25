# Name: Pilfer
# Website: https://github.com/digitalsleuth/forensics_tools
# Description: Use Windows LOL-BINS (Living off the Land Binaries) to do rapid triage / system profiling
# Category: Standalones
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3.0 (https://github.com/digitalsleuth/forensics_tools/blob/master/LICENSE)
# Notes: 
# Version: 2.4

pilfer-download:
  file.managed:
    - name: 'C:\standalone\pilfer\pilfer.bat'
    - source: https://github.com/digitalsleuth/forensics_tools/raw/master/pilfer.bat
    - source_hash: sha256=60fcc8bc76846692d105f4c996552d1ca7d497393c90df69c5f7b2106242ae73
    - makedirs: True

pilfer-env-vars:
  win_path.exists:
    - name: 'C:\standalone\pilfer\'
    - require:
      - file: pilfer-download
