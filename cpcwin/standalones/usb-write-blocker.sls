# Name: USB Registry Write Blocker
# Website: https://github.com/digitalsleuth/registry-write-block
# Description: USB Write Blocker for standard USB / UASP devices using Registry Modifications
# Category: Write Blockers
# Author: Corey Forman (digitalsleuth)
# License: MIT License (https://github.com/digitalsleuth/Registry-Write-Block/blob/master/LICENSE)
# Version: 1.2
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '1.2' %}
{% set hash = '7b52d5b84310bfaec1f9cfb739e7b1c8731af1eb73d9ed4cfeb31bb7118ad2b0' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

cpcwin-standalones-usb-write-blocker:
  file.managed:
    - name: '{{ inpath }}\usb-write-blocking\USB-Write-Blocker_v{{ version }}.exe'
    - source: https://github.com/digitalsleuth/Registry-Write-Block/releases/download/{{ version }}/USB-Registry-Write-Block-PS3x64-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

cpcwin-standalones-usb-write-blocker-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\USB Write Blocker.lnk'
    - target: '{{ inpath }}\usb-write-blocking\USB-Write-Blocker_v1.2.exe'
    - force: True
    - working_dir: '{{ inpath }}\'
    - makedirs: True
    - require:
      - file: cpcwin-standalones-usb-write-blocker

cpcwin-standalones-usb-write-blocker-cmd:
  file.managed:
    - name: '{{ inpath }}\usb-write-blocking\USB-Registry-Write-Block.cmd'
    - source: salt://cpcwin/files/USB-Registry-Write-Block.cmd
    - makedirs: True

cpcwin-standalones-usb-write-blocker-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\usb-write-blocking\'
