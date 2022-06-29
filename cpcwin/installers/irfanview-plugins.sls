# Name: IrfanView Plugins
# Website: https://www.irfanview.com
# Description: Photo Editor
# Category: Utilities
# Author: Irfan Skilijan
# License: EULA - https://www.irfanview.com/eula.htm
# Version: 459
# Notes:

{% set hash = '7742d47f49293f885c42d6b566d2d55335b79d454a024bff3ee113dd8b8bb41c' %}
{% set url_version = '459' %}

include:
  - cpcwin.packages.irfanview

irfanview-plugins-source:
  file.managed:
    - name: 'C:\salt\tempdownload\iview{{ url_version }}_plugins_x64_setup.exe'
    - source: https://download.betanews.com/download/1099412658-1/iview{{ url_version }}_plugins_x64_setup.exe
    - source_hash: sha256={{ hash }}
    - makedirs: True

irfanview-plugins-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\iview{{ url_version }}_plugins_x64_setup.exe /silent'
    - shell: cmd
    - require:
      - sls: cpcwin.packages.irfanview
