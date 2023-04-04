include:
  - cpcwin.wsl.wsl
 
cpcwin-wsl:
  test.nop:
    - require:
      - sls: cpcwin.wsl.wsl
