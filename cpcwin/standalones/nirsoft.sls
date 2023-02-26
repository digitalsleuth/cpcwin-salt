# Name: Nirsoft
# Website: https://nirsoft.net
# Description: Suite of various Windows Analysis Tools
# Category: Windows Analysis
# Author: Nir Sofer
# License: 
# Version: 1.23.70
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}
{% set version = '1.23.70' %}
{% set hash = '7120472b45946148fc7fbfa1cb3aabb77e86c85b0b0235814093d314857a79ef' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set nlps = ['eztools.nlp', 'ntcore.nlp', 'mitec.nlp', 'CMPFOR-Custom.nlp', 'sysinternals6.nlp'] %}

include:
  - cpcwin.packages.7zip
  - cpcwin.standalones.sysinternals
  - cpcwin.standalones.mitec
  - cpcwin.standalones.ntcore

nirsoft-defender-exclusion:
  cmd.run:
    - name: 'Add-MpPreference -ExclusionPath "{{ inpath }}\"'
    - shell: powershell

nirsoft-download:
  cmd.run:
    - name: 'wget -O C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -Headers @{"Referer"="https://launcher.nirsoft.net/downloads/index.html"} https://download.nirsoft.net/nirsoft_package_enc_{{ version }}.zip'
    - shell: powershell
    - require:
      - cmd: nirsoft-defender-exclusion

nirsoft-extract:
  cmd.run:
    - name: '"C:\Program Files\7-Zip\7z.exe" x C:\salt\tempdownload\nirsoft_package_enc_{{ version }}.zip -o"{{ inpath }}\nirsoft\" -pnirsoft9876$ -y'
    - shell: cmd
    - require:
      - cmd: nirsoft-defender-exclusion
      - cmd: nirsoft-download
    - watch:
      - cmd: nirsoft-defender-exclusion

cpcwin-standalones-nirsoft-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\NirLauncher.lnk'
    - target: '{{ inpath }}\nirsoft\NirLauncher.exe'
    - force: True
    - working_dir: '{{ inpath }}\nirsoft\'
    - makedirs: True
    - require:
      - cmd: nirsoft-extract

cpcwin-standalones-nirsoft-cfg-replace:
  file.managed:
    - name: '{{ inpath }}\nirsoft\NirLauncher.cfg'
    - source: salt://cpcwin/files/NirLauncher.cfg
    - replace: True
    - require:
      - sls: cpcwin.standalones.sysinternals
      - sls: cpcwin.standalones.mitec
      - sls: cpcwin.standalones.ntcore

{% for nlp in nlps %}

cpcwin-standalones-nirsoft-{{ nlp }}:
  file.managed:
    - name: '{{ inpath }}\nirsoft\{{ nlp }}'
    - source: salt://cpcwin/files/{{ nlp }}
    - makedirs: True

cpcwin-standalones-nirsoft-{{ nlp }}-placeholder:
  file.replace:
    - name: '{{ inpath }}\nirsoft\{{ nlp }}'
    - pattern: PLACEHOLDER_PATH
    - repl: {{ inpath | regex_escape }}
    - require:
      - file: cpcwin-standalones-nirsoft-{{ nlp }}

{% endfor %}
