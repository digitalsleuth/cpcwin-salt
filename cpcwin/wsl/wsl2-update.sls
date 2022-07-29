include:
  - cpcwin.repos

wsl2-update:
  pkg.installed:
    - require:
      - sls: cpcwin.repos
