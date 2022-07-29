include:
  - cpcwin.config.user
  - cpcwin.config.debloat-windows
#  - cpcwin.config.layout
  - cpcwin.config.computer-name
  - cpcwin.config.pdfs
  - cpcwin.config.del-edge-shortcut
  - cpcwin.config.admin-cmd-prompt
  - cpcwin.config.admin-posh-prompt

cpcwin-config:
  test.nop:
    - require:
      - sls: cpcwin.config.user
      - sls: cpcwin.config.debloat-windows
#      - sls: cpcwin.config.layout
      - sls: cpcwin.config.computer-name
      - sls: cpcwin.config.pdfs
      - sls: cpcwin.config.del-edge-shortcut
      - sls: cpcwin.config.admin-cmd-prompt
      - sls: cpcwin.config.admin-posh-prompt
