# Name: USBRegview
# Website: https://github.com/ms-cpc/USBRegview
# Description: Batch file to automate loading registry hives into USBDeview
# Category: Windows Analysis
# Author: Mark Southby
# License: None
# Version: 20220413b
# Notes: 

{% set inpath = salt['pillar.get']('inpath', 'C:\standalone') %}

include:
  - cpcwin.packages.git

usbregview-git:
  git.latest:
    - name: https://github.com/ms-cpc/USBRegview
    - target: '{{ inpath }}\usbregview'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

usbregview-env-vars:
  win_path.exists:
    - name: '{{ inpath }}\usbregview\'
