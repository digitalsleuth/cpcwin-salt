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
