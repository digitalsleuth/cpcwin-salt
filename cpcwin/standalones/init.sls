include:
  - cpcwin.standalones.zimmerman
  - cpcwin.standalones.sysinternals
  - cpcwin.standalones.evtx-dump
  - cpcwin.standalones.cyberchef
  - cpcwin.standalones.nirsoft
  - cpcwin.standalones.eventfinder
  - cpcwin.standalones.regripper
  - cpcwin.standalones.usb-write-blocker
#  - cpcwin.standalones.ntfs-log-tracker
#  - cpcwin.standalones.logfileparser
#  - cpcwin.standalones.kape
  - cpcwin.standalones.sqlitestudio
  - cpcwin.standalones.autorunner
  - cpcwin.standalones.sleuthkit
#  - cpcwin.standalones.logparser-studio
#  - cpcwin.standalones.kansa
#  - cpcwin.standalones.logviewer2
#  - cpcwin.standalones.officemalscanner
  - cpcwin.standalones.srum-dump2
  - cpcwin.standalones.pilfer
  - cpcwin.standalones.vssmount
#  - cpcwin.standalones.silketw
#  - cpcwin.standalones.offvis
  - cpcwin.standalones.megatools
  - cpcwin.standalones.arsenal-image-mounter
#  - cpcwin.standalones.velociraptor
  - cpcwin.standalones.winpmem
  - cpcwin.standalones.magnet-edd
  - cpcwin.standalones.magnet-process-capture
  - cpcwin.standalones.magnet-ram-capture
#  - cpcwin.standalones.magnet-web-page-saver-portable
#  - cpcwin.standalones.psdecode
  - cpcwin.standalones.x-ways
  - cpcwin.standalones.caine
  - cpcwin.standalones.rufus

cpcwin-standalones:
  test.nop:
    - require:
      - sls: cpcwin.standalones.zimmerman
      - sls: cpcwin.standalones.sysinternals
      - sls: cpcwin.standalones.evtx-dump
      - sls: cpcwin.standalones.cyberchef
      - sls: cpcwin.standalones.nirsoft
      - sls: cpcwin.standalones.eventfinder
      - sls: cpcwin.standalones.regripper
      - sls: cpcwin.standalones.usb-write-blocker
#      - sls: cpcwin.standalones.ntfs-log-tracker
#      - sls: cpcwin.standalones.logfileparser
#      - sls: cpcwin.standalones.kape
      - sls: cpcwin.standalones.sqlitestudio
      - sls: cpcwin.standalones.autorunner
      - sls: cpcwin.standalones.sleuthkit
#      - sls: cpcwin.standalones.logparser-studio
#      - sls: cpcwin.standalones.kansa
#      - sls: cpcwin.standalones.logviewer2
#      - sls: cpcwin.standalones.officemalscanner
      - sls: cpcwin.standalones.srum-dump2
      - sls: cpcwin.standalones.pilfer
      - sls: cpcwin.standalones.vssmount
#      - sls: cpcwin.standalones.silketw
#      - sls: cpcwin.standalones.offvis
      - sls: cpcwin.standalones.megatools
      - sls: cpcwin.standalones.arsenal-image-mounter
#      - sls: cpcwin.standalones.velociraptor
      - sls: cpcwin.standalones.winpmem
      - sls: cpcwin.standalones.magnet-edd
      - sls: cpcwin.standalones.magnet-process-capture
      - sls: cpcwin.standalones.magnet-ram-capture
#      - sls: cpcwin.standalones.magnet-web-page-saver-portable
#      - sls: cpcwin.standalones.psdecode
      - sls: cpcwin.standalones.x-ways
      - sls: cpcwin.standalones.caine
      - sls: cpcwin.standalones.rufus
