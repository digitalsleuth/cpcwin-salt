# Name: Pilfer
# Website: https://github.com/digitalsleuth/forensics_tools
# Description: Use Windows LOL-BINS (Living off the Land Binaries) to do rapid triage / system profiling
# Category: Standalones
# Author: Corey Forman (digitalsleuth)
# License: GNU General Public License v3.0 (https://github.com/digitalsleuth/forensics_tools/blob/master/LICENSE)
# Notes: 

pilfer-download:
  file.managed:
    - name: 'C:\standalone\pilfer\pilfer.bat'
    - source: https://github.com/digitalsleuth/forensics_tools/raw/master/pilfer.bat
    - source_hash: sha256=18aa57372d9dcb4188fda5cedbc80de823a635a06f3aae7249b3b3a28e8d82d4
    - makedirs: True

pilfer-env-vars:
  win_path.exists:
    - name: 'C:\standalone\pilfer\'
    - require:
      - file: pilfer-download
