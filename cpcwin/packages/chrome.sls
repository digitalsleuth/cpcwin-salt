# Name: Google Chrome
# Website: https://www.google.com
# Description: Google Web Browser
# Category: Requirements
# Author: Google
# License: https://policies.google.com/terms
# Version: 103.0.5060.66
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

chrome:
  pkg.installed

chrome-del-shortcut:
  file.absent:
    - names:
      - 'C:\Users\Public\Desktop\Google Chrome.lnk'
      - '{{ home }}\Desktop\Google Chrome.lnk'
    - require:
      - pkg: chrome
      - user: cpcwin-user-{{ user }}
