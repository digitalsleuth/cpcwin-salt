include:
  - cpcwin.packages.git

usbregview-git:
  git.latest:
    - name: https://github.com/ms-cpc/USBRegview
    - target: 'C:\standalone\usbregview'
    - rev: main
    - force_clone: True
    - force_reset: True
    - require:
      - sls: cpcwin.packages.git

usbregview-env-vars:
  win_path.exists:
    - name: 'C:\standalone\usbregview\'
