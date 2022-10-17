{% set user = salt['pillar.get']('cpcwin_user', 'forensics') %}
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
