# Name: Rufus
# Website: https://rufus.ie
# Description: USB ISO Creator
# Category: Utilities
# Author: Pete Batard
# License: GNU General Public License v3 - https://github.com/pbatard/rufus/blob/master/LICENSE.txt
# Version: 3.18
# Notes:

{% set version = '3.18' %}
{% set hash = '22820692cb7295cd13bf62ab984a8f5b37e3cb09999b6aa2ad27a704e3380c48' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

rufus-download:
  file.managed:
    - name: 'C:\standalone\rufus\rufus-{{ version }}.exe'
    - source: 'https://github.com/pbatard/rufus/releases/download/v{{ version }}/rufus-{{ version }}.exe'
    - source_hash: sha256={{ hash }}
    - makedirs: True

cpcwin-standalones-rufus-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Rufus.lnk'
    - target: 'C:\standalone\rufus\rufus-{{ version }}.exe'
    - force: True
    - working_dir: 'C:\standalone\rufus\'
    - makedirs: True
    - require:
      - file: rufus-download

