include:
  - cpcwin.config
  - cpcwin.addon
  - cpcwin.config.layout
  - cpcwin.theme
 
cpcwin-dedicated:
  test.nop:
    - require:
      - sls: cpcwin.config
      - sls: cpcwin.addon
      - sls: cpcwin.config.layout
      - sls: cpcwin.theme
