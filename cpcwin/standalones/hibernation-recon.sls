# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes:

{% set hash = '60BB6C8C6F24FDBBBB2A3EAA1F9601F21ED36327F57735FE3E8F3E25C6619AD6' %}
{% set version = '1.2.2.85' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

include:
  - cpcwin.standalones.megatools
  - cpcwin.packages.dotnet6-desktop-runtime

hiber-recon-remove-previous:
  file.absent:
    - name: 'C:\salt\tempdownload\Hibernation-Recon-v{{ version }}.zip'

hiber-recon-download:
  cmd.run:
    - name: 'C:\standalone\megatools\megatools.exe dl https://mega.nz/file/PowEiY4S#2T087NqeVypCD77MmINi7jEoDKOPsVpnRMwQJKXQZys --path C:\salt\tempdownload'
    - shell: cmd
    - require:
      - sls: cpcwin.standalones.megatools
      - file: hiber-recon-remove-previous

hiber-recon-extract:
  archive.extracted:
    - name: 'C:\standalone\'
    - enforce_toplevel: True
    - source: 'C:\salt\tempdownload\Hibernation-Recon-v{{ version }}.zip'
    - source_hash: sha256={{ hash }}
    - overwrite: True
    - require:
      - sls: cpcwin.standalones.megatools
      - cmd: hiber-recon-download
      - sls: cpcwin.packages.dotnet6-desktop-runtime

hiber-recon-folder-rename:
  file.rename:
    - name: 'C:\standalone\hibernation-recon'
    - source: 'C:\standalone\Hibernation-Recon-v{{ version }}\'
    - force: True
    - makedirs: True
    - require:
      - archive: hiber-recon-extract

cpcwin-standalones-hiber-recon-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Hibernation Recon.lnk'
    - target: 'C:\standalone\hibernation-recon\HibernationRecon.exe'
    - force: True
    - working_dir: 'C:\standalone\hibernation-recon\'
    - makedirs: True
    - require:
      - sls: cpcwin.standalones.megatools
      - cmd: hiber-recon-download
      - archive: hiber-recon-extract
      - file: hiber-recon-folder-rename

cpcwin-standalones-hiber-recon-path:
  win_path.exists:
    - name: 'C:\standalone\hibernation-recon\'
    - require:
      - file: cpcwin-standalones-hiber-recon-shortcut
