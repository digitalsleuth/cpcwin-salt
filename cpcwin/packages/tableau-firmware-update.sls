# Name: Tableau Firmware Update
# Website: https://www.opentext.com
# Description: Firmware update utility for Tableau forensic devices
# Category: Write Blockers
# Author: OpenText
# License: EULA
# Version: 22.3.2
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

tableau-certificate-copy:
  file.managed:
    - name: 'C:\salt\tempdownload\tableau.cer'
    - source: salt://cpcwin/files/tableau.cer
    - makedirs: True

tableau-certificate-install:
  certutil.add_store:
    - name: 'C:\salt\tempdownload\tableau.cer'
    - store: TrustedPublisher
    - require:
      - file: tableau-certificate-copy

tableau-firmware-update:
  pkg.installed:
    - require:
      - certutil: tableau-certificate-install

tableau-firmware-update-icon-del:
  file.absent:
    - names:
      - '{{ home }}\Desktop\Tableau Firmware Update.lnk'
      - 'C:\Users\Public\Desktop\Tableau Firmware Update.lnk'
    - require:
      - pkg: tableau-firmware-update
      - user: cpcwin-user-{{ user }}

