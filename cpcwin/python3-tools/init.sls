include:
  - cpcwin.python3-tools.volatility3
  - cpcwin.python3-tools.autotimeliner
  - cpcwin.python3-tools.bitsparser
  - cpcwin.python3-tools.usbdeviceforensics
  - cpcwin.python3-tools.iptools
#  - cpcwin.python3-tools.oledump
#  - cpcwin.python3-tools.rtfdump
#  - cpcwin.python3-tools.msoffcrypto-crack
#  - cpcwin.python3-tools.xlmmacrodeobfuscator
#  - cpcwin.python3-tools.oletools
#  - cpcwin.python3-tools.pdfid
#  - cpcwin.python3-tools.wleapp
#  - cpcwin.python3-tools.aleapp
#  - cpcwin.python3-tools.ileapp
#  - cpcwin.python3-tools.vleapp
  - cpcwin.python3-tools.time-decode

cpcwin-python3-tools:
  test.nop:
    - require:
      - sls: cpcwin.python3-tools.volatility3
      - sls: cpcwin.python3-tools.autotimeliner
      - sls: cpcwin.python3-tools.bitsparser
      - sls: cpcwin.python3-tools.usbdeviceforensics
      - sls: cpcwin.python3-tools.iptools
#      - sls: cpcwin.python3-tools.oledump
#      - sls: cpcwin.python3-tools.rtfdump
#      - sls: cpcwin.python3-tools.msoffcrypto-crack
#      - sls: cpcwin.python3-tools.xlmmacrodeobfuscator
#      - sls: cpcwin.python3-tools.oletools
#      - sls: cpcwin.python3-tools.pdfid
#      - sls: cpcwin.python3-tools.wleapp
#      - sls: cpcwin.python3-tools.aleapp
#      - sls: cpcwin.python3-tools.ileapp
#      - sls: cpcwin.python3-tools.vleapp
      - sls: cpcwin.python3-tools.time-decode

python3-filetype-association:
  cmd.run:
    - name: 'ftype Python.File="C:\Windows\py.exe" %L %*'
    - shell: cmd

python3-pathext:
  cmd.run:
    - names:
      - setx /M PATHEXT "%PATHEXT:;.PY;.PYW=%"
      - setx /M PATHEXT "%PATHEXT%;.PY;.PYW"
    - shell: cmd
