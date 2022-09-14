# Name: 
# Website: 
# Description: 
# Category: 
# Author: 
# License: 
# Notes: 

{% set hash = '7864ce0ab57e3831bad24f56abc1c9c6796a552091d2f49262e66565e66c0447' %}
{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set applications = ['EZViewer','Hasher','JumpListExplorer','MFTExplorer','RegistryExplorer','SDBExplorer','ShellBagsExplorer','TimelineExplorer'] %}

zimmerman-tools:
  file.managed:
    - name: 'C:\salt\tempdownload\Get-ZimmermanTools.zip'
    - source: https://f001.backblazeb2.com/file/EricZimmermanTools/Get-ZimmermanTools.zip
    - source_hash: sha256={{ hash }}
    - makedirs: True

zimmerman-tools-install:
  archive.extracted:
    - name: 'C:\standalone\zimmerman\'
    - source: 'C:\salt\tempdownload\Get-ZimmermanTools.zip'
    - enforce_toplevel: False
    - watch:
      - file: zimmerman-tools

zimmerman-tools-download:
  cmd.run:
    - name: "powershell -ep bypass C:\\standalone\\zimmerman\\Get-ZimmermanTools.ps1 -Dest C:\\standalone\\zimmerman"
    - shell: powershell

zimmerman-env-vars:
  win_path.exists:
    - names:
      - 'C:\standalone\zimmerman\'
      - 'C:\standalone\zimmerman\EvtxECmd\'
      - 'C:\standalone\zimmerman\RegistryExplorer\'
      - 'C:\standalone\zimmerman\ShellBagsExplorer\'
      - 'C:\standalone\zimmerman\SQLECmd\'
      - 'C:\standalone\zimmerman\iisGeolocate\'

{% for application in applications %}
zimmerman-{{ application }}-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\{{ application }}.lnk'
    - target: 'C:\standalone\zimmerman\{{ application }}\{{ application }}.exe'
    - force: True
    - working_dir: 'C:\standalone\zimmerman\{{ application }}\'
    - makedirs: True
    - require:
      - cmd: zimmerman-tools-download
{% endfor %}
