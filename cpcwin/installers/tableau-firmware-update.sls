{% set user = salt['pillar.get']('cpcwin_user', 'forensics') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}

include:
  - cpcwin.config.user

tableau-firmware-update-download:
  file.managed:
    - name: '{{ home }}\Desktop\setup_tableau_firmware_update_22.3.msi'
    - source: https://mimage.opentext.com/support/ecm/tableau/setup_tableau_firmware_update_22.3.msi
    - source_hash: sha256=72da20b80e25ff34d43c44e7f2844707cf21863d5524885a7cfdff1e2a9f7edf
    - makedirs: True

