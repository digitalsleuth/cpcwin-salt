# Name: Free Hex Editor Neo
# Website: https://www.hhdsoftware.com/free-hex-editor
# Description: Hex Editor
# Category: Raw Parsers / Decoders
# Author: HHD Software
# License: Terms Of Use - https://www.hhdsoftware.com/company/terms-of-use
# Version: 7.01.00.7839
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

free-hex-editor-neo:
  pkg.installed

free-hex-editor-icon:
  file.absent:
    - names:
      - '{{ home }}\Desktop\Hex Editor Neo.lnk'
      - 'C:\Users\Public\Desktop\Hex Editor Neo.lnk'
    - require:
      - user: cpcwin-user-{{ user }}
      - pkg: free-hex-editor-neo
