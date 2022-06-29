# Name: PDF Stream Dumper
# Website: https://github.com/dzzie/pdfstreamdumper
# Description: PDF Analysis Tool
# Category: Document Analysis
# Author: David Zimmer
# License: 
# Version: 0.9.624
# Notes: 

{% set user = salt['pillar.get']('cpcwin_user', 'forensics') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}

include:
  - cpcwin.config.user

pdfstreamdumper:
  pkg.installed

pdfstreamdumper-icon-remove:
  file.absent:
    - name: '{{ home }}\Desktop\PdfStreamDumper.exe.lnk'
    - require:
      - user: cpcwin-user-{{ user }}
      - pkg: pdfstreamdumper
