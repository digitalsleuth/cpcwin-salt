# Name: FTK Imager
# Website: https://www.exterro.com
# Description: Forensic Image Acquisition and Triage tool
# Category: Acquisition and Analysis
# Author: Exterro Inc / AccessData
# License: EULA
# Version: 4.7.0.19
# Notes: 

ftk-imager:
  pkg.installed

ftk-imager-icon-remove:
  file.absent:
    - name: 'C:\Users\Public\Desktop\AccessData FTK Imager.lnk'
    - require:
      - pkg: ftk-imager
