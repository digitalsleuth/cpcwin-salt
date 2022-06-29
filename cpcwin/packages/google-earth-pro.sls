google-earth-pro:
  pkg.installed

remove-google-earth-icon:
  file.absent:
    - name: 'C:\Users\Public\Desktop\Google Earth Pro.lnk'
    - require:
      - pkg: google-earth-pro
