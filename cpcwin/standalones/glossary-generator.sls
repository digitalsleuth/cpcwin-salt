# Name:
# Website:
# Description:
# Category:
# Author:
# License:
# Notes:

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

glossary-generator-archive:
  archive.extracted:
    - name: 'C:\standalone\'
    - source: salt://cpcwin/files/gg.zip
    - enforce_toplevel: false

glossary-generator-folder-rename:
  file.rename:
    - name: 'C:\standalone\glossary-generator'
    - source: 'C:\standalone\Glossary Generator\'
    - force: True
    - makedirs: True
    - require:
      - archive: glossary-generator-archive
 
cpcwin-standalones-glossary-generator-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Glossary Generator.lnk'
    - target: 'C:\standalone\glossary-generator\GG.exe'
    - force: True
    - working_dir: 'C:\standalone\glossary-generator\'
    - makedirs: True
    - require:
      - archive: glossary-generator-archive
