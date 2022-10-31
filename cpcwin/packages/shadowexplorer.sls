include:
  - cpcwin.installers.dotnetfx35

shadowexplorer:
  pkg.installed:
    - require:
      - sls: cpcwin.installers.dotnetfx35
