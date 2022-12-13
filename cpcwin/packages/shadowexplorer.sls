# Name: Shadow Explorer
# Website: https://www.shadowexplorer.com
# Description: Windows Volume Shadow Copy viewer
# Category: Windows Analysis
# Author: ShadowExplorer
# License: 
# Version: 0.9.462.0
# Notes: 

include:
  - cpcwin.packages.dotnetfx35

shadowexplorer:
  pkg.installed:
    - require:
      - sls: cpcwin.packages.dotnetfx35
    - watch:
      - sls: cpcwin.packages.dotnetfx35
