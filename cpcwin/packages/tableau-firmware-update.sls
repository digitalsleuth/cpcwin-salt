{% set user = salt['pillar.get']('cpcwin_user', 'forensics') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}


tableau-firmware-update:
  pkg.installed

tableau-firmware-update-icon-del:
  file.absent:
    - names:
      - '{{ home }}\Desktop\Tableau Firmware Update.lnk'
    - require:
      - pkg: tableau-firmware-update
      - user: cpcwin-user-{{ user }}

