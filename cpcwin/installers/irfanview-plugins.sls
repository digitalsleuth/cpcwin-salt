# Name: IrfanView x64 Plugins
# Website: https://www.irfanview.com/64bit.htm
# Description: Irfanview Plugins
# Category: Utilities
# Author: Irfan Skiljan
# License: EULA - https://www.irfanview.com/eula.htm
# Version: 4.62
# Notes:

{% set version = '462' %}
{% set hash = '29542a9229a36e4e7be5a9b2a3a433632ddc06e40fe2324ad7317b0679b389dc' %}

include:
  - cpcwin.packages.irfanview

irfanview-plugins-source:
  file.managed:
    - name: 'C:\salt\tempdownload\iview{{ version }}_plugins_x64_setup.exe'
    - source: https://download.betanews.com/download/1099412658-1/iview{{ version }}_plugins_x64_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

irfanview-plugins-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\iview{{ version }}_plugins_x64_setup.exe /silent'
    - shell: cmd
    - require:
      - sls: cpcwin.packages.irfanview
