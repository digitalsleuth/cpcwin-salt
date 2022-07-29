{% set hash = 'c1bae838ab7759dbccac5fe44827f770bdaec4009c190e4edc218beb8f3d637c' %}

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
    - vdata: 6

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


