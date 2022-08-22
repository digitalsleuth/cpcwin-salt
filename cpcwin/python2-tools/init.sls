include:
  - cpcwin.python2-tools.volatility2

cpcwin-python2-tools:
  test.nop:
    - require:
      - sls: cpcwin.python2-tools.volatility2

