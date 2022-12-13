# Name: Reference Documentation
# Website: SANS.org and github.com/digitalsleuth/winfor-salt
# Description: Reference documents for tools and forensic cheatsheets
# Category: Utilities
# Author: SANS and Corey Forman
# License: 
# Version: 
# Notes: Source https://github.com/teamdfir/sift-saltstack/blob/master/sift/config/user/pdfs.sls and WIN-FOR tool list

{% set PROGRAMDATA = salt['environ.get']('PROGRAMDATA') %}

{%-
set pdfs = [
  {
    "id": "poster-threat-intelligence",
    "filename": "Poster_Threat-Intelligence-Consumption.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt85ecf5919805e543/Threat_Intel_Poster.pdf",
    "hash": "02f71ad97ece95e9bea61db31fe026b7b6c7e04a2a1f3257b51ace3153e88d59",
  },
  {
    "id": "poster-network-forensics",
    "filename": "Network-Forensics-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltf474461c7e1bc333/Network_Forensis_Poster.pdf",
    "hash": "66ba6fb482b9f2c1ad9da5b8c379b1acff14dbd96bf6bf1046f39a4960e56b3c",
  },
  {
    "id": "poster-sift-remnux",
    "filename": "SIFT-REMnux-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt1bc0b6b59a82bfa5/SIFT_&_REMnux_Poster.pdf",
    "hash": "5719b21c388d276984b5200f29561e093d02bc4dc2553889c4b8011f984fb0f0"
  },
  {
    "id": "poster-dfir-smartphone",
    "filename": "DFIR-Smartphone-Forensics-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt83bf07bbc4a716d9/Smartphone_Forensics_Poster.pdf",
    "hash": "98c9be2bc34e52ebb0448741d08f0c7fb44a2aba7d8e2232005f64b0bb6c7006"
  },
  {
    "id": "poster-windows-forensics",
    "filename": "Windows-Forensics-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltc39305369fb54116/Windows_Forensic_Poster.pdf",
    "hash": "a835554f0354cbddf98f333c8c860e43504adf45fadffadd8d4e6468ffcf8d2c"
  },
  {
    "id": "poster-ios-third-pary-apps",
    "filename": "iOS-3rd-Party-Apps-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/bltad8650d3ff00e675/iOS_Third_Party_Forensic_Poster.pdf",
    "hash": "2f1b2b67a12d43de29014cce0097f4e58538b0bf9d9c48cedc4516b7b0aea78e"
  },
  {
    "id": "poster-zimmerman-tools",
    "filename": "Zimmerman-Tools-Poster.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt83d26bfaab457108/EZ_Tools_Poster.pdf",
    "hash": "8cbc02298b743217ffebd5887787d7bad7b4ea30715f9a74715aa31c41f8b7cc"
  },
  {
    "id": "poster-hunt-evil",
    "filename": "Hunt-Evil.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt251af6afae29ea60/Hunt_Evil_Poster.pdf",
    "hash": "74fea603f50e389667a341c4d77ac6bd511f7b841d836edd640889b963ea0753"
  },
  {
    "id": "cheatsheet-sift",
    "filename": "SIFT-Cheatsheet.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt67fa8fb616555ec1/SIFT_WorkStation_CHeat_Sheet.pdf",
    "hash": "8fda96c8f7bc32844b843dd3d95e793316e23b765b440b240681d3bc9724ad5c"
  },
  {
    "id": "cheatsheet-windows-to-unix",
    "filename": "Windows-to-Unix-Cheatsheet.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt0f47176890413e4d/Windows_to_Unix_Cheat_Sheet.pdf",
    "hash": "97be37ea175c0f53a808c45fcbeacd11889d77a566d2a01d421865bb4c352312"
  },
  {
    "id": "cheatsheet-hexfile-regex",
    "filename": "Hex-File-Regex-Cheatsheet.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt925c54638a43145c/Hex_and_Regex_Forensics_Cheat_Sheet.pdf",
    "hash": "d1a78b37886f524bc94e3e3aac8ab9816e904a6583f0145fd26c67524e23d032"
  },
  {
    "id": "cheatsheet-sqlite",
    "filename": "SQLite-Pocket-Reference.pdf",
    "source": "https://assets.contentstack.io/v3/assets/blt36c2e63521272fdc/blt4698e96e2d9cf51d/SQlite_Cheat_Sheet.pdf",
    "hash": "954d62787abe3bad95f59e2d671eac202dea2607ed5cdb757dbbb688b873f679"
  },
  {
    "id": "cpcwin-tool-list",
    "filename": "CPC-WIN-Tool-List.pdf",
    "source": "salt://cpcwin/files/CPC-WIN-Tool-List.pdf",
    "hash": "189cf22af1106c7e6d3940b0bd9eb6c20573f168ba157e34191cab50e2dcab89"
  },

]
-%}

{% for pdf in pdfs %}
cpcwin-pdf-{{ pdf.id }}:
  file.managed:
    - name: 'C:\standalone\references\{{ pdf.filename }}'
    - source: {{ pdf.source }}
    - source_hash: sha256={{ pdf.hash }}
    - makedirs: True
    - show_changes: False
{% endfor %}

cpcwin-tool-list-shortcut:
  file.shortcut:
    - name: '{{ PROGRAMDATA }}\Microsoft\Windows\Start Menu\Programs\CPC-WIN-Tool-List.lnk'
    - target: 'C:\standalone\references\CPC-WIN-Tool-List.pdf'
    - force: True
    - working_dir: 'C:\standalone\references\'
    - makedirs: True
