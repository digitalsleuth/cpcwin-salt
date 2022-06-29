# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

{% set version = '1.2' %}
{% set hash = '7b52d5b84310bfaec1f9cfb739e7b1c8731af1eb73d9ed4cfeb31bb7118ad2b0' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

cpcwin-standalones-usb-write-blocker:
  file.managed:
    - name: 'C:\standalone\USB-Write-Blocker_v{{ version }}.exe'
    - source: https://github.com/digitalsleuth/Registry-Write-Block/releases/download/{{ version }}/USB-Registry-Write-Block-PS3x64-v{{ version }}.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

cpcwin-standalones-usb-write-blocker-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\USB Write Blocker.lnk'
    - target: 'C:\standalone\USB-Write-Blocker_v1.2.exe'
    - force: True
    - working_dir: 'C:\standalone\'
    - makedirs: True
    - require:
      - file: cpcwin-standalones-usb-write-blocker

cpcwin-standalones-usb-write-blocker-env-vars:
  win_path.exists:
    - name: 'C:\standalone\'
