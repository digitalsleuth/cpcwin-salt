# Name: Python 3
# Website: https://python.org
# Description: Python Programming Language
# Category: Programming
# Author: Python Software Foundation
# License: https://docs.python.org/3.10/license.html
# Version: 3.10.1150.0
# Notes:

python3_x64:
  pkg.installed:
    - version: '3.10.1150.0'

python3-wheel:
  pip.installed:
    - name: wheel
    - bin_env: 'C:\Program Files\Python310\python.exe'
    - require:
      - pkg: python3_x64

python3-env-vars:
  win_path.exists:
    - names:
      - 'C:\Program Files\Python310\Scripts\'
      - 'C:\Program Files\Python310\'
    - index: 0

python3-symlink:
  file.symlink:
    - name: 'C:\Program Files\Python310\python3.exe'
    - target: 'C:\Program Files\Python310\python.exe'
    - force: True
    - makedirs: True
    - win_inheritance: True
    - require:
      - pkg: python3_x64
