# Name: Veracrypt
# Website: https://www.veracrypt.fr/code/VeraCrypt/
# Description: Encrypted container creation and management
# Category: Utilities
# Author: https://github.com/veracrypt/VeraCrypt/blob/master/doc/html/Authors.html
# License: Apache License v2 (https://github.com/veracrypt/VeraCrypt/blob/master/License.txt)
# Version: 1.25.9
# Notes: 

{% set user = salt['pillar.get']('cpcwin_user', 'user') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}

include:
  - cpcwin.config.user

veracrypt:
  pkg.installed

veracrypt-icon-del:
  file.absent:
    - names:
      - '{{ home }}\Desktop\VeraCrypt.lnk'
      - 'C:\Users\Public\Desktop\VeraCrypt.lnk'
    - require:
      - pkg: veracrypt
      - user: cpcwin-user-{{ user }}
