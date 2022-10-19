{% set zips = ['FTK-Imager-4-7-1-2-portable.zip', 'FTK-Imager-3-2-0-0-portable.zip', 'searchkit.zip'] %}
{% set folders = ['PE01', 'PE03', 'PE04', 'PE05', 'PE06', 'PE07'] %}

{% for zip in zips %}

{{ zip }}-zip-copy:
  file.managed:
    - name: 'C:\salt\tempdownload\{{ zip }}'
    - source: salt://cpcwin/files/{{ zip }}
    - makedirs: True

{{ zip }}-zip-extract:
  archive.extracted:
    - name: 'C:\SEARCHKIT_USB\'
    - source: 'C:\salt\tempdownload\{{ zip }}'
    - enforce_toplevel: False
    - require:
      - file: {{ zip }}-zip-copy

{% endfor %}

searchkit-zip-cleanup:
  file.absent:
    - name: 'C:\salt'

{%for folder in folders %}

searchkit-{{ folder }}-folder:
  file.managed:
    - name: 'C:\SEARCHKIT_USB\Evidence\{{ folder }}\'
    - makedirs: True

{% endfor %}
