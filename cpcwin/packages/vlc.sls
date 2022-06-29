vlc:
  pkg.installed

vlc-del-shortcut:
  file.absent:
    - names:
      - 'C:\Users\Public\Desktop\VLC media player.lnk'
    - require:
      - pkg: vlc
