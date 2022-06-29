include:
  - cpcwin.wsl.wsl
  - cpcwin.wsl.wsl2-update
  - cpcwin.wsl.wsl-config
 
cpcwin-wsl:
  test.nop:
    - require:
      - sls: cpcwin.wsl.wsl
      - sls: cpcwin.wsl.wsl2-update
      - sls: cpcwin.wsl.wsl-config
