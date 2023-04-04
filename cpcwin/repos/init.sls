cpcwin-repos-add-1:
  file.replace:
    - name: 'C:\ProgramData\Salt Project\salt\conf\minion'
    - pattern: 'winrepo_remotes_ng:'
    - repl: 'winrepo_remotes_ng:'
    - append_if_not_found: True
    - count: 1

cpcwin-repos-add-2:
  file.replace:
    - name: 'C:\ProgramData\Salt Project\salt\conf\minion'
    - pattern: '  - main https://github.com/digitalsleuth/salt-winrepo-ng.git'
    - repl: '  - main https://github.com/digitalsleuth/salt-winrepo-ng.git'
    - append_if_not_found: True
    - count: 1
    - require:
      - file: cpcwin-repos-add-1

cpcwin-repos-add-3:
  file.replace:
    - name: 'C:\ProgramData\Salt Project\salt\conf\minion'
    - pattern: 'winrepo_remotes: '
    - repl: 'winrepo_remotes:'
    - append_if_not_found: True
    - count: 1
    - require:
      - file: cpcwin-repos-add-1
      - file: cpcwin-repos-add-2

cpcwin-repos-update:
  cmd.run:
    - name: '"C:\Program Files\Salt Project\Salt\salt-call.bat" --local winrepo.update_git_repos && "C:\Program Files\Salt Projects\Salt\salt-call.bat" --local pkg.refresh_db'
    - require:
      - file: cpcwin-repos-add-1
      - file: cpcwin-repos-add-2
      - file: cpcwin-repos-add-3

