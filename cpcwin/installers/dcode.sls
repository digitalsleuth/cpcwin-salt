# Name: DCode
# Website: https://www.digital-detective.net/dcode
# Description: Timestamp encoder/decoder
# Category: Raw Parsers / Decoders
# Author: Craig Wilson (https://www.digital-detective.net)
# License: 
# Version: 5.5.21194.40
# Notes: 

{% set version = '5.5.21194.40' %}
{% set hash = 'dbb23d6ea4f572fbaec017fb8acc2a8b62b74fafa81ea4a388966ec14087a9e4' %}

dcode:
  file.managed:
    - name: C:\\salt\\tempdownload\\DCode-x86-EN-{{ version }}.zip
    - source: https://www.digital-detective.net/download/downloadbac.php?downcode=ae2znu5994j1lforlh03
    - source_hash: sha256={{ hash }}
    - makedirs: True

dcode-archive:
  archive.extracted:
    - name: C:\\salt\\tempdownload\\dcode
    - source: C:\\salt\\tempdownload\\DCode-x86-EN-{{ version }}.zip
    - enforce_toplevel: False
    - watch:
      - file: dcode

dcode-install:
  cmd.run:
    - name: "C:\\salt\\tempdownload\\dcode\\DCode-x86-EN-{{ version }}.exe /SP- /VERYSILENT /NORESTART /MERGETASKS=!RUNCODE,ADDCONTEXTMENUFILES,ADDCONTEXTMENUFOLDERS,ADDTOPATH,!DESKTOPICON"
    - require:
      - file: dcode
      - archive: dcode-archive
