ms-powertoys:
  pkg.installed

taskkill-powertoys-settings-window:
  cmd.run:
    - name: 'taskkill /F /IM "PowerToys.Settings.exe"'
    - bg: True
    - require:
      - pkg: ms-powertoys
