# Name: X-Ways Forensics
# Website: https://x-ways.net
# Description: Forensic Analysis Software
# Category: Acquisition and Analysis
# Author: Stefan Fleischmann
# License: License Dependent - https://www.x-ways.net/terminology.html
# Version: 20.7 SR-2 x64
# Notes:

{% set version = "207" %}
{% set auth_token = "TOKENPLACEHOLDER" %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set xwhash = "83ef47673964e53cb54a83878a79e92c0e73518b09196583204627037168895b" %}
{% set xviewerhash = "544b69c75823d351abb35a2eaa7d7ba40760e012db22cdf45c0f82b6392a1f3b" %}
{% set mplayerhash = "a3a13bbda7ba0052c71521124e428f490648ea452f3bcbcf31860b9d0120ed25" %}
{% set tesseracthash = "95c484205c6474b7b7ef5109a3412666090857c44999cf72f06f55dc9c239310" %}
{% set manualhash = "b4e990c8181a962891aa742b522c8cedabe41f8c7dbbeed4e9d3d6575e940d0a" %}

{% if salt['file.directory_exists']('C:\\salt\\tempdownload\\') %}
temp-directory-exists:
  test.nop
{% else %}
create-temp-directory:
  file.directory:
    - name: 'C:\salt\tempdownload\'
    - makedirs: True
{% endif %}

{% if auth_token == "TOKENPLACEHOLDER" %}

xways-credentials-not-provided:
  test.nop

{% else %}

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\xw_forensics' + version + '.zip') and salt['file.check_hash']('C:\\salt\\tempdownload\\xw_forensics' + version + '.zip', xwhash)%}
xways-already-downloaded-and-hash-verified:
  test.nop
{% else %}
xways-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/xwf/xw_forensics{{ version }}.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\xw_forensics{{ version }}.zip'
    - shell: powershell
{% endif %}

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\xw_viewer.zip') and salt['file.check_hash']('C:\\salt\\tempdownload\\xw_viewer.zip', xviewerhash)%}
xways-viewer-already-downloaded-and-hash-verified:
  test.nop
{% else %}
xways-viewer-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/viewer/xw_viewer.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\xw_viewer.zip'
    - shell: powershell
{% endif %}

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\Tesseract.zip') and salt['file.check_hash']('C:\\salt\\tempdownload\\Tesseract.zip', tesseracthash)%}
xways-tesseract-already-downloaded-and-hash-verified:
  test.nop
{% else %}
xways-tesseract-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/Tesseract.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\Tesseract.zip'
    - shell: powershell
{% endif %}

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\MPlayer_2018_x64.zip') and salt['file.check_hash']('C:\\salt\\tempdownload\\MPlayer_2018_x64.zip', mplayerhash)%}
xways-mplayer-already-downloaded-and-hash-verified:
  test.nop
{% else %}
xways-mplayer-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/res/mplayer/MPlayer 2018 x64.zip" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\MPlayer_2018_x64.zip'
    - shell: powershell
{% endif %}

{% if salt['file.file_exists']('C:\\salt\\tempdownload\\manual.pdf') and salt['file.check_hash']('C:\\salt\\tempdownload\\manual.pdf', manualhash)%}
xways-manual-already-downloaded-and-hash-verified:
  test.nop
{% else %}
xways-manual-download:
  cmd.run:
    - name: 'Invoke-WebRequest -Uri "http://www.x-ways.net/winhex/manual.pdf" -Method GET -Headers @{ Authorization = "Basic {{ auth_token }}" } -UserAgent "IPWorks HTTPComponent - www.nsoftware.com" -UseBasicParsing -OutFile C:\salt\tempdownload\manual.pdf'
    - shell: powershell
{% endif %}

{% set dirs = ['C:\\X-Ways' + version + '\\','C:\\CASE_FOLDER_STRUCTURE\\X-Ways' + version + '\\'] %}
{% for dir in dirs %}

xways-extract-{{ dir }}:
  archive.extracted:
    - name: '{{ dir }}'
    - source: 'C:\salt\tempdownload\xw_forensics{{ version }}.zip'
    - enforce_toplevel: False

xways-viewer-extract-{{ dir }}:
  archive.extracted:
    - name: '{{ dir }}'
    - source: 'C:\salt\tempdownload\xw_viewer.zip'
    - enforce_toplevel: False
    - require:
      - archive: xways-extract-{{ dir }}

xways-tesseract-extract-{{ dir }}:
  archive.extracted:
    - name: '{{ dir }}'
    - source: 'C:\salt\tempdownload\Tesseract.zip'
    - enforce_toplevel: False
    - require:
      - archive: xways-extract-{{ dir }}

xways-mplayer-extract-{{ dir }}:
  archive.extracted:
    - name: '{{ dir }}'
    - source: 'C:\salt\tempdownload\MPlayer_2018_x64.zip'
    - enforce_toplevel: False
    - require:
      - archive: xways-extract-{{ dir }}

xways-manual-copy-{{ dir }}:
  file.managed:
    - name: '{{ dir }}manual.pdf'
    - source: 'C:\salt\tempdownload\manual.pdf'
    - require:
      - archive: xways-extract-{{ dir }}

xways-winhex-binary-{{ dir }}:
  file.copy:
    - name: '{{ dir }}winhex.exe'
    - source: '{{ dir }}xwforensics.exe'
    - require:
      - archive: xways-extract-{{ dir }}

xways-winhex64-binary-{{ dir }}:
  file.copy:
    - name: '{{ dir }}winhex64.exe'
    - source: '{{ dir }}xwforensics64.exe'
    - require:
      - archive: xways-extract-{{ dir }}

xways-file-type-categories-user-{{ dir }}:
  file.managed:
    - name: '{{ dir }}File Type Categories User.txt'
    - source: salt://cpcwin/files/File_Type_Categories_User.txt
    - skip_verify: True
    - require:
      - archive: xways-extract-{{ dir }}

{% endfor %}

cpcwin-standalones-xways-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\X-Ways.lnk'
    - target: 'C:\X-Ways{{ version }}\xwforensics64.exe'
    - force: True
    - working_dir: 'C:\X-Ways{{ version }}\'
    - makedirs: True
    - require:
      - cmd: xways-download

cpcwin-standalones-winhex-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\WinHex.lnk'
    - target: 'C:\X-Ways{{ version }}\winhex64.exe'
    - force: True
    - working_dir: 'C:\X-Ways{{ version }}\'
    - makedirs: True
    - require:
      - cmd: xways-download

{% endif %}
