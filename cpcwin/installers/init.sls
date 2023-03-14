include:
  - cpcwin.installers.dcode
  - cpcwin.installers.hxd
  - cpcwin.installers.systools-pst-viewer
  - cpcwin.installers.irfanview-plugins
  - cpcwin.installers.magnet-axiom
  - cpcwin.installers.fastcopy
  - cpcwin.installers.jre8
  - cpcwin.installers.mobaxterm
  
cpcwin-installers:
  test.nop:
    - require:
      - sls: cpcwin.installers.dcode
      - sls: cpcwin.installers.hxd
      - sls: cpcwin.installers.systools-pst-viewer
      - sls: cpcwin.installers.irfanview-plugins
      - sls: cpcwin.installers.magnet-axiom
      - sls: cpcwin.installers.fastcopy
      - sls: cpcwin.installers.jre8
      - sls: cpcwin.installers.mobaxterm
