call dps_obsidian#setup({
  \   'vaults': [
  \     {
  \       'name': 'remote',
  \       'path': $OBSIDIAN_VAULT_REMOTE,
  \       'note': {
  \         'dir': 'notes',
  \         'template': 'standard.md',
  \       },
  \       'daily_note': {
  \         'dir': 'notes/daily',
  \         'template': 'daily.md',
  \       },
  \       'template_dir': 'config/template'
  \     }
  \   ]
  \ })

" Set abreviations
cabbr obn ObsidianNewNote
cabbr obt ObsidianToday
cabbr oby ObsidianYesterday
