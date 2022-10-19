{% set hash = 'c1bae838ab7759dbccac5fe44827f770bdaec4009c190e4edc218beb8f3d637c' %}
{% set case_folders = ['Evidence', 'Export', 'Temp', 'Xways'] %}

cpcwin-theme-wallpaper-source:
  file.managed:
    - name: 'C:\standalone\cpc-wallpaper-cmpfor-4k.jpg'
    - source: salt://cpcwin/theme/cpc-wallpaper-cmpfor-4k.jpg
    - source_hash: sha256={{ hash }}
    - makedirs: True
    - win_inheritance: True

cpcwin-theme-desktop-background-color:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Colors
    - vname: Background
    - vtype: REG_SZ
    - vdata: "0 0 0"

cpcwin-theme-set-wallpaper:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: WallPaper
    - vtype: REG_SZ
    - vdata: 'C:\standalone\cpc-wallpaper-cmpfor-4k.jpg'

cpcwin-theme-set-wallpaper-center:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: WallpaperStyle
    - vtype: REG_SZ
    - vdata: 10

cpcwin-theme-set-wallpaper-no-tile:
  reg.present:
    - name: HKEY_CURRENT_USER\Control Panel\Desktop
    - vname: TileWallpaper
    - vtype: REG_SZ
    - vdata: 0

cpcwin-theme-update-wallpaper:
  cmd.run:
    - name: 'RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True'
    - shell: cmd

nimi-setup:
  file.managed:
    - name: 'C:\salt\tempdownload\nimi.zip'
    - source: salt://cpcwin/files/nimi.zip
    - makedirs: True

nimi-extract:
  archive.extracted:
    - name: 'C:\standalone\nimi\'
    - source: 'C:\salt\tempdownload\nimi.zip'
    - enforce_toplevel: False
    - require:
      - file: nimi-setup

nimi-autostart:
  reg.present:
    - name: HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run
    - vname: NimiPlaces
    - vtype: REG_SZ
    - vdata: '"C:\standalone\nimi\nimi.cmd"'

nimi-run:
  cmd.run:
    - name: '"Nimi Places.exe"'
    - cwd: 'C:\standalone\nimi\'
    - bg: True
    - require:
      - reg: nimi-autostart

cleanup-nimi:
  file.absent:
    - name: 'C:\salt'
    - require:
      - cmd: nimi-run

{% for folder in case_folders %}
make-{{ folder }}-folder:
  file.managed:
    - name: 'C:\CASE_FOLDER_STRUCTURE\{{ folder }}\'
    - makedirs: True

{% endfor %}
