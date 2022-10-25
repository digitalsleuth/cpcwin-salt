# Name: Nirsoft
# Website: https://nirsoft.net
# Description: Suite of various Windows Analysis Tools
# Category: Windows Analysis
# Author: Nir Sofer
# License: 
# Version: 1.23.65
# Notes: 

{% set version = '1.23.65' %}
{% set hash = 'e89d352d37940b7dbd9dbb8503a4526e50c0ae82f38ac639527283925951d597' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set nlps = ['eztools.nlp', 'ntcore.nlp', 'mitec.nlp', 'CMPFOR-Custom.nlp', 'sysinternals5.nlp'] %}

include:
  - cpcwin.packages.7zip
  - cpcwin.standalones.sysinternals
  - cpcwin.standalones.mitec
  - cpcwin.standalones.ntcore

nirsoft-download:
  cmd.run:
    - name: 'wget -O C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -Headers @{"Referer"="https://launcher.nirsoft.net/downloads/index.html"} https://download.nirsoft.net/nirsoft_package_enc_{{ version }}.zip'
    - shell: powershell

nirsoft-defender-exclusion:
  cmd.run:
    - name: 'Add-MpPreference -ExclusionPath "C:\standalone\"'
    - shell: powershell
    - require:
      - cmd: nirsoft-download

nirsoft-extract:
  cmd.run:
    - name: '"C:\Program Files\7-Zip\7z.exe" x C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -o"C:\standalone\nirsoft\" -pnirsoft9876$ -y'
    - shell: cmd
    - require:
      - cmd: nirsoft-defender-exclusion

cpcwin-standalones-nirsoft-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\NirLauncher.lnk'
    - target: 'C:\standalone\nirsoft\NirLauncher.exe'
    - force: True
    - working_dir: 'C:\standalone\nirsoft\'
    - makedirs: True
    - require:
      - cmd: nirsoft-extract

cpcwin-standalones-nirsoft-cfg-replace:
  file.managed:
    - name: 'C:\standalone\nirsoft\NirLauncher.cfg'
    - source: salt://cpcwin/files/NirLauncher.cfg
    - replace: True
    - require:
      - sls: cpcwin.standalones.sysinternals
      - sls: cpcwin.standalones.mitec
      - sls: cpcwin.standalones.ntcore

{% for nlp in nlps %}

cpcwin-standalones-nirsoft-{{ nlp }}:
  file.managed:
    - name: 'C:\standalone\nirsoft\{{ nlp }}'
    - source: salt://cpcwin/files/{{ nlp }}
    - makedirs: True

{% endfor %}
