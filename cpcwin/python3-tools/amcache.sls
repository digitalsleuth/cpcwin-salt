include:
  - cpcwin.packages.python3

amcache-file-copy:
  file.managed:
    - name: 'C:\Program Files\Python310\Scripts\amcache.py'
    - source: salt://cpcwin/files/amcache.py
    - makedirs: True
    - require:
      - sls: cpcwin.packages.python3

amcache-wrapper:
  file.managed:
    - name: 'C:\Program Files\Python310\Scripts\amcache.cmd'
    - win_inheritance: True
    - contents:
      - '@echo off'
      - 'python3 "C:\Program Files\Python310\Scripts\amcache.py" %*'
    - require:
      - file: amcache-file-copy
