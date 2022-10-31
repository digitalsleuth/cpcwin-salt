{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}
{% set files = [
                ('ADOQuery', 'A412293B10AD00B0A94509CD48AD389C4F609B96FA504CCBBB2501742E3AD96D'), 
                ('DataEdit', '9F950880508760C6709CCAADDC9D630903C9AE661DC99C50A5BAA85642141C46'),
                ('DirList', '635E8D311EB99A2730AECFF405272E1B0B92636763051E41D451961D3B9C0E26'),
                ('NetScanner', '15CC706B3A3FD735674729D0BE2084FBC56A1FB8FD4E113C27B632E7D7FEF7F6'),
                ('TMX', 'BFCE0718D2FA54ACAB5A74443170B1ACFCA77E9FE6A47058790B40546EABEA71'), 
                ('SE', 'F9CEF0A01409A03B6EE42A6AE4AE64A71A4923CDA3E1E62C0E5998AF03FC938F'), 
                ('IHB', '94d513e5507e871b7d87246676f1072a92386e0b352ef7e02473a5812fd292db'),
                ('EHB', '6ECC87D4A0061CEDC13CCC398EB66009C39C5E36931737BB1841A373DE22C363'),
                ('WFA', '57ACAE30EA14576E06822703C6211C8F0C675286C989EE0CDAFEC23578E7A9C6'), 
                ('WRR', '6FC38AC70B3A73829D045580327C057A3738D9158E67776F5DD788B91B940334'),
                ('SSView', '4b9ffce3bfb53013b860cbf2af97b847cb3f259d5bb8633106caa94ac006a483'), 
                ('HEXEdit', 'CFE264A121C560D69E2BB95512BE407F374164F2F79D0DDC4CEB7A8D0A09C788'),
                ('MailView', 'C2590633A9B13CC9D46A41A2980347057C84D8788A4597B83FFCC057FFD5B774'), 
                ('EXE', '86573B2455A2CE7F8D4997A17170044B8F62A258923BDDDC1982AC8F2213544B'),
                ('XMLView', '93A22A6FAD75EB806E0B2EB54116E6470C7EDEE6ACBE299828DFB6A66DD45CE5'),
                ('JSONView', 'BC49223C10FAFC9110AEC17A64071A4BD91E3CFEF9BC0A167027D92F19197379'),
                ('PhotoView', '6BCBB3AAFD3DB71E7CBDFB75D78934101DED79A5792F52FBAE600EC16910795C')
               ] %}

{% for file, hash in files %}

mitec-download-{{ file }}:
  file.managed:
    - name: C:\salt\tempdownload\{{ file }}.zip
    - source: http://mitec.cz/Downloads/{{ file }}.zip
    - source_hash: sha256={{ hash }}
    - makedirs: true

mitec-unzip-{{ file }}:
  archive.extracted:
    - name: C:\standalone\mitec\{{ file }}
    - source: C:\salt\tempdownload\{{ file }}.zip
    - enforce_toplevel: false
    - require:
      - file: mitec-download-{{ file }}

cpcwin-standalones-mitec-{{ file }}-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\{{ file }}.lnk'
    - target: 'C:\standalone\mitec\{{ file }}\{{ file }}.exe'
    - force: True
    - working_dir: 'C:\standalone\mitec\{{ file }}\'
    - makedirs: True
    - require:
      - archive: mitec-unzip-{{ file }}

{% endfor %}

mitec-download-sqliteq:
  file.managed:
    - name: C:\salt\tempdownload\SQLiteQ.zip
    - source: http://mitec.cz/Downloads/SQLiteQ.zip
    - source_hash: sha256=7F979A622DE9E97B9682DC09A5156A1BD872139A9DD56BA60616FB824E77AB16
    - makedirs: True

mitec-unzip-sqliteq:
  archive.extracted:
    - name: C:\standalone\mitec\SQLiteQ
    - source: C:\salt\tempdownload\SQLiteQ.zip
    - enforce_toplevel: false
    - require:
      - file: mitec-download-sqliteq

cpcwin-standalones-mitec-sqliteq-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\SQLiteQuery.lnk'
    - target: 'C:\standalone\mitec\SQLiteQ\SQLiteQuery.exe'
    - force: True
    - working_dir: 'C:\standalone\mitec\SQLiteQ\'
    - makedirs: True
    - require:
      - archive: mitec-unzip-sqliteq
