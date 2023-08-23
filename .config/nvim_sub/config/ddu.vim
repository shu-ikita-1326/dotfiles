" for lsp
highlight DduRed guifg=red
highlight DduLightBlue guifg=lightblue
highlight DduYellow guifg=yellow
highlight DduGreen guifg=green

" alias
call ddu#custom#alias('ui', 'ff_ghq', 'ff')
call ddu#custom#alias('ui', 'ff_colorscheme', 'ff')

" custom actions
call ddu#custom#action('source', 'buffer', 'close',
      \ { args -> execute("for item in args.items\n execute('bdelete! ' . item.action.bufNr)\n endfor") })

" global settings
call ddu#custom#patch_global(#{
      \  ui: 'ff',
      \  filterParams: #{
      \    matcher_fzf: #{
      \      highlightMatched: 'Search',
      \    },
      \  },
      \  sources: [{'name': 'file_rec', 'params': {}}],
      \  sourceParams: #{
      \    file_external: #{
      \      cmd: ['fd', '.', '-H', '-E', '__pycache__', '-t', 'f'],
      \    },
      \  },
      \  sourceOptions: #{
      \    _: #{
      \      matchers: ['matcher_fzf'],
      \      sorters: ['sorter_fzf'],
      \      ignoreCase: v:true,
      \    },
      \    lsp_diagnostic: #{
      \      converters: ['converter_lsp_diagnostic'],
      \    },
      \    lsp_documentSymbol: #{
      \      converters: ['converter_lsp_symbol'],
      \    },
      \    lsp_workspaceSymbol: #{
      \      converters: ['converter_lsp_symbol'],
      \    },
      \    git_status: #{
      \      converters: ['converter_git_status'],
      \    },
      \    file: #{
      \      columns: ['icon_filename'],
      \    },
      \    file_rec: #{
      \      columns: [#{name: 'icon_filename', params: #{ pathDisplayOption: 'relative' }}],
      \    },
      \    mr: #{
      \      columns: [#{name: 'icon_filename', params: #{ pathDisplayOption: 'relative' }}],
      \    },
      \    file_external: #{
      \      columns: [#{name: 'icon_filename', params: #{ pathDisplayOption: 'relative' }}],
      \    },
      \  },
      \  kindOptions: #{
      \    file: #{
      \      defaultAction: 'open',
      \    },
      \    man: #{
      \      defaultAction: 'open',
      \    },
      \    word: #{
      \      defaultAction: 'append',
      \    },
      \    command_history: #{
      \      defaultAction: 'execute',
      \    },
      \    help: #{
      \      defaultAction: 'open',
      \    },
      \    readme_viewer: #{
      \      defaultAction: 'open',
      \    },
      \    git_status: #{
      \      defaultAction: 'open',
      \    },
      \    ghq: #{
      \      defaultAction: 'open',
      \    },
      \    lsp: #{
      \      defaultAction: 'open',
      \    },
      \    lsp_codeAction: #{
      \      defaultAction: 'apply',
      \    },
      \    action: #{
      \      defaultAction: 'do',
      \    },
      \    nvim-notify: #{
      \      defaultAction: 'open',
      \    },
      \    source: #{
      \      defaultAction: 'execute',
      \    },
      \    colorscheme: #{
      \      defaultAction: 'set',
      \    },
      \    dein_update: #{
      \      defaultAction: 'viewDiff',
      \    },
      \    floaterm: #{
      \      defaultAction: 'open',
      \    },
      \    window: #{
      \      defaultAction: 'open',
      \    },
      \  },
      \  actionOptions: #{
      \    echo: #{
      \      quit: v:false,
      \    },
      \    echoDiff: #{
      \      quit: v:false,
      \    },
      \    set: #{
      \      quit: v:false,
      \    },
      \  },
      \  columnParams: #{
      \    icon_filename: #{
      \      customFileIcons: #{
      \        lua: #{ icon: '' },
      \        txt: #{ icon: '' },
      \        vue: #{ icon: '' },
      \       },
      \     },
      \  },
      \  uiParams: #{
      \    _: #{
      \      filterSplitDirection: 'floating',
      \      split: 'floating',
      \      filterFloatingPosition: 'top',
      \      floatingBorder: 'rounded',
      \      previewFloating: v:true,
      \      previewSplit: 'vertical',
      \      previewFloatingBorder: 'rounded',
      \      previewFloatingTitle: 'Preview',
      \      previewFloatingTitlePos: 'center',
      \      floatingTitle: 'Result',
      \      floatingTitlePos: 'center',
      \      filterFloatingTitle: 'matcher: fzf',
      \    },
      \    ff: #{
      \      autoAction: #{
      \        name: 'preview',
      \      },
      \    },
      \    ff_colorscheme: #{
      \      autoAction: #{
      \        name: 'itemAction',
      \      },
      \    },
      \    ff_ghq: #{
      \      autoAction: #{
      \        name: 'preview',
      \        params: #{
      \          previewCmds: ['onefetch', '%s']
      \        },
      \      },
      \    },
      \    filer: #{
      \      sortTreesFirst: v:true,
      \    },
      \  },
      \})

" layout settings
function! s:set_size() abort
  let s:winCol = (&columns - (&columns * 0.9)) / 2
  let s:winWidth = floor(&columns * 0.9)
  let s:winRow = 6
  let s:winHeight = &lines - 10
  let s:previewCol = floor(&columns / 2)
  let s:previewWidth = floor((&columns * 0.9) / 2 - 1)
  let s:previewRow = 7
  let s:previewHeight = &lines - 12
endfunction

function! s:set_layout() abort
call ddu#custom#patch_global('uiParams', #{
      \  _: #{
      \    winCol: s:winCol,
      \    winRow: s:winRow,
      \    winWidth: s:winWidth,
      \    winHeight: s:winHeight,
      \    previewCol: s:previewCol,
      \    previewWidth: s:previewWidth,
      \    previewRow: s:previewRow,
      \    previewHeight: s:previewHeight,
      \  },
      \ })
endfunction

function! s:layout() abort
  call s:set_size()
  call s:set_layout()
endfunction

call s:layout()

autocmd VimResized * call s:layout()

" local settings
call ddu#custom#patch_local("lsp_def", #{
      \  ui: 'ff',
      \  uiParams: #{
      \    ff: #{
      \      startAutoAction: v:true,
      \      autoAction: #{
      \        name: 'preview'
      \      },
      \    },
      \  },
      \  sources: [
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduRed' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>Definition<<',
      \      }
      \    },
      \    #{ name: 'lsp_definition', params: #{ method: 'textDocument/definition' }},
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduLightBlue' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>typeDefinition<<',
      \      },
      \    },
      \    #{ name: 'lsp_definition', params: #{ method: 'textDocument/typeDefinition' }},
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduYellow' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>declaration<<',
      \      }
      \    },
      \    #{ name: 'lsp_definition', params: #{ method: 'textDocument/declaration' }},
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduGreen' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>Implementation<<',
      \      }
      \    },
      \    #{ name: 'lsp_definition', params: #{ method: 'textDocument/implementation' }},
      \  ],
      \})

call ddu#custom#patch_local("lsp_hie", #{
      \  ui: 'ff',
      \  uiParams: #{
      \    ff: #{
      \      startAutoAction: v:true,
      \      autoAction: #{
      \        name: 'preview'
      \      },
      \    },
      \  },
      \  sources: [
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduRed' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>incomingCalls<<',
      \      }
      \    },
      \    #{ name: 'lsp_callHierarchy', params: #{ method: 'callHierarchy/incomingCalls' }},
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduLightBlue' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>outgoingCalls<<',
      \      }
      \    },
      \    #{ name: 'lsp_callHierarchy', params: #{ method: 'callHierarchy/outgoingCalls' }},
      \    #{
      \      name: 'dummy',
      \      options: #{
      \        converters: [
      \          #{ name: 'converter_highlight', params: #{ hl_group: 'DduYellow' } },
      \        ],
      \      },
      \      params: #{
      \        display: '>>Reference<<',
      \      }
      \    },
      \    #{ name: 'lsp_references' },
      \  ],
      \})

" key mapping
nnoremap <silent> <Leader>fe :Ddu -ui=filer file<CR>
nnoremap <silent> <Leader>fw :Ddu -ui=ff window -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>ff :Ddu -ui=ff file_external -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>
nnoremap <silent> <Leader>h :Ddu -ui=ff mr -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>hp :Ddu -ui=ff mr -source-param-ff-kind=mrr<CR>
nnoremap <silent> <Leader>fr :Ddu -ui=ff register -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>/ :Ddu -ui=ff rg -source-option-ff-volatile=v:true -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>
nnoremap <silent> <Leader>fb :Ddu -ui=ff buffer -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>fh :Ddu -ui=ff help -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>
nnoremap <silent> <Leader>fc :Ddu -ui=ff command_history<CR>
nnoremap <silent> <Leader>co :Ddu -ui=ff_colorscheme colorscheme<CR>
nnoremap <silent> <Leader>fm :Ddu -ui=ff marks -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>fn :Ddu -ui=ff nvim-notify -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>fj :Ddu -ui=ff jumplist -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>fs :Ddu -ui=ff source -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>gs :Ddu -ui=ff git_status -source-option-ff-path=`expand('%:p')` -source-option-ff-converter='converter_git_status' -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>gd :Ddu -ui=ff git_diff -source-option-ff-path=`expand('%:p')`<CR>
nnoremap <silent> <Leader>gl :Ddu -ui=ff git_log -source-param-ff-showGraph -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>gh :Ddu -ui=ff ghq -ui='ff_ghq' -ui-param-ff_ghq-startAutoAction<CR>
nnoremap <silent> <Leader>fd :Ddu -ui=ff dein -ui-param-ff-startFilter=v:true<CR>
nnoremap <silent> <Leader>fl :Ddu -ui=ff line -ui-param-ff-startFilter=v:true -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>ft :Ddu -name=floaterm -ui=ff floaterm -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>* :Ddu -ui=ff rg -resume=v:false -ui-param-ff-startAutoAction -ui-param-ff-ignoreEmpty -source-param-ff-input=`('<cword>'->expand())`<CR>
nnoremap <silent> gd :call ddu#start({ 'name': 'lsp_def' })<CR>
nnoremap <silent> gs :call ddu#start({ 'name': 'lsp_hie' })<CR>
nnoremap <silent> ge :Ddu -ui=ff lsp_diagnostic -ui-param-ff-startAutoAction<CR>
nnoremap <silent> <Leader>ca :Ddu -ui=ff lsp_codeAction -ui-param-ff-startAutoAction<CR>
nnoremap <silent> ds :Ddu -ui=ff lsp_documentSymbol -ui-param-ff-startAutoAction<CR>

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  setlocal cursorline
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> i
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> a
        \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
  nnoremap <buffer> <C-c>
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('togglePreview')<CR>
  nnoremap <buffer> <C-t>
        \ <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>
  nnoremap <buffer> <C-u>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-u>"})<CR>
  nnoremap <buffer> <C-d>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-d>"})<CR>
  nnoremap <buffer> <C-n>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-e>"})<CR>
  nnoremap <buffer> <C-p>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-y>"})<CR>
  nnoremap <buffer> L
        \ <Cmd>call ddu#ui#do_action('expandItem')<CR>
  nnoremap <buffer> H
        \ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
  nnoremap <buffer> <Tab>
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> A
        \ <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
  if split(bufname(), '-')[-1] == 'floaterm'
    nnoremap <buffer> d
          \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'close' })<CR>
  endif
endfunction

" toggle matchers function
function! g:Ddu_toggle_matchers(name) abort
  let s:current_options = ddu#custom#get_current(a:name)
  if s:current_options.sourceOptions._.matchers == ['matcher_fzf']
    call ddu#ui#do_action('updateOptions', #{
          \  sourceOptions: #{
          \    _: #{
          \      matchers: ['matcher_substring'],
          \      sorters: [],
          \    },
          \  },
          \  uiParams: #{
          \    _: #{
          \      startFilter: v:true,
          \      filterFloatingTitle: 'matcher: substring',
          \    },
          \  },
          \ })
  else
    call ddu#ui#do_action('updateOptions', #{
          \  sourceOptions: #{
          \    _: #{
          \      matchers: ['matcher_fzf'],
          \      sorters: [],
          \    },
          \  },
          \  uiParams: #{
          \    _: #{
          \      startFilter: v:true,
          \      filterFloatingTitle: 'matcher: fzf',
          \    },
          \  },
          \ })
  endif
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR><Esc>
  inoremap <buffer> <C-c>
        \ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
  inoremap <buffer> <C-n>
        \ <Cmd>call ddu#ui#do_action('cursorNext')<CR>
  inoremap <buffer> <C-p>
        \ <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>
  inoremap <buffer> <Esc>
        \ <Esc><Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>
  inoremap <buffer> <C-f> <Esc><Cmd>call g:Ddu_toggle_matchers('default')<CR>
  nnoremap <buffer> <C-c>
        \ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('togglePreview')<CR>
  nnoremap <buffer> <C-t>
        \ <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_filer_my_settings()
function! s:ddu_filer_my_settings() abort
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> <C-c>
        \ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
  nnoremap <buffer> h
        \ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
  nnoremap <buffer> l
        \ <Cmd>call ddu#ui#do_action('expandItem')<CR>
  nnoremap <buffer> a
        \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('togglePreview')<CR>
  nnoremap <buffer> <Tab>
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> <C-u>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-u>"})<CR>
  nnoremap <buffer> <C-d>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-d>"})<CR>
  nnoremap <buffer> <C-n>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-e>"})<CR>
  nnoremap <buffer> <C-p>
        \ <Cmd>call ddu#ui#do_action('previewExecute', { 'command': "normal! \<C-y>"})<CR>
endfunction
