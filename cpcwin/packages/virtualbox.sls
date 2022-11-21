virtualbox:
  pkg.installed

remove-virtualbox-shortcut:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Oracle VM VirtualBox.lnk'
    - require:
      - pkg: virtualbox
