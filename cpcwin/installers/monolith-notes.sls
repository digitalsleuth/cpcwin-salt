# Currently Monolith Notes is set to auto pull / check for updates from a 
# non-accesible IP address, which appears to belong to another company / entity
# Since it's possible it might pull down something unexpected, this state is
# temporarily disabled in the init, but can be manually installed if desired.

{% set hash = 'e5834378b6d0ac51f8fcd74b3f2fc5fd6924a3e5808548967602805acc9b68e1' %}

monolith-notes-download:
  file.managed:
    - name: 'C:\salt\tempdownload\Monolith Notes Setup.exe'
    - source: "https://monolith-cloud.nyc3.cdn.digitaloceanspaces.com/updates/notes/Monolith%20Notes%20Setup.exe"
    - source_hash: sha256={{ hash }}
    - makedirs: True

monolith-notes-install:
  cmd.run:
    - name: 'C:\salt\tempdownload\Monolith Notes Setup.exe'
    - require:
      - file: monolith-notes-download

monolith-notes-close:
  cmd.run:
    - name: 'taskkill /F /IM "Monolith Notes.exe"'
    - require:
      - cmd: monolith-notes-install
