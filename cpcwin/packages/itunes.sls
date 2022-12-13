# Name: Apple iTunes
# Website: https://www.apple.com
# Description: Media viewer and Apple device manager
# Category: Utilities
# Author: Apple
# License: EULA
# Version: 12.11.3.17
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

itunes:
  pkg.installed

itunes-icon:
  file.absent:
    - name: 'C:\Users\Public\Desktop\iTunes.lnk'
    - require:
      - user: cpcwin-user-{{ user }}
      - pkg: itunes
