{% set hash = 'c1bae838ab7759dbccac5fe44827f770bdaec4009c190e4edc218beb8f3d637c' %}
{% set case_folders = ['Evidence', 'Export', 'Temp', 'Xways'] %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

cpcwin-theme-wallpaper-source:
  file.managed:
    - name: 'C:\standalone\cpc-wallpaper-cmpfor-4k.png'
    - source: salt://cpcwin/theme/cpc-wallpaper-cmpfor-4k.png
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
    - vdata: 'C:\standalone\cpc-wallpaper-cmpfor-4k.png'

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

nimi-taskkill:
  cmd.run:
    - name: 'taskkill /F /IM "Nimi Places.exe"'
    - bg: True

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

cleanup-nimi:
  file.absent:
    - name: 'C:\salt'
    - require:
      - cmd: nimi-autostart

{% for folder in case_folders %}

make-{{ folder }}-folder:
  file.directory:
    - name: 'C:\CASE_FOLDER_STRUCTURE\{{ folder }}\'
    - makedirs: True
    - replace: True
    - win_inheritance: True

{% endfor %}

nimi-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\Nimi Places.lnk'
    - target: 'C:\standalone\nimi\nimi.cmd'
    - force: True
    - working_dir: 'C:\standalone\nimi'
    - icon_location: 'C:\standalone\nimi\Nimi Places.exe'
    - makedirs: True
    - require:
      - archive: nimi-extract
