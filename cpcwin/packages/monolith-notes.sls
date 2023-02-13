# Name: Monolith Notes
# Website: https://www.monolithforensics.com/
# Description: Forensic note taking and tracking tool
# Category: Utilities
# Author: Monolith Forensics
# License: EULA
# Version: 1.0.1
# Notes: 

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set PROGRAMFILES = salt['environ.get']('PROGRAMFILES') %}
{% set user = salt['pillar.get']('winfor_user', 'forensics') %}
{% set all_users = salt['user.list_users']() %}
{% if user in all_users %}
  {% set home = salt['user.info'](user).home %}
{% else %}
{% set home = "C:\\Users\\" + user %}
{% endif %}

include:
  - cpcwin.config.user

monolith-notes:
  pkg.installed

monolith-notes-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Monolith Notes.lnk'
    - target: '{{ PROGRAMFILES }}\Monolith Notes\Monolith Notes.exe'
    - force: True
    - working_dir: '{{ PROGRAMFILES }}\Monolith Notes\'
    - makedirs: True
    - require:
      - pkg: monolith-notes

monolith-desktop-shortcut:
  file.absent:
    - name: '{{ home }}\Desktop\Monolith Notes.lnk'
    - require:
      - pkg: monolith-notes
      - user: user-{{ user }}
