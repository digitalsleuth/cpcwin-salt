include:
  - cpcwin.config.user
  - cpcwin.repos
  - cpcwin.packages
  - cpcwin.installers
  - cpcwin.standalones
  - cpcwin.python2-tools
  - cpcwin.python3-tools
  - cpcwin.searchkit
  - cpcwin.cleanup

cpcwin-addon-version-file:
  file.managed:
    - name: 'C:\ProgramData\Salt Project\Salt\srv\salt\cpcwin-version'
    - source: salt://cpcwin/VERSION
    - require:
      - sls: cpcwin.config.user
      - sls: cpcwin.repos
      - sls: cpcwin.packages
      - sls: cpcwin.installers
      - sls: cpcwin.standalones
      - sls: cpcwin.python2-tools
      - sls: cpcwin.python3-tools
      - sls: cpcwin.searchkit
      - sls: cpcwin.cleanup
