" Create custom
call ddu#custom#patch_global(#{
	\   ui: 'ff',
	\   sources: [
	\     {
	\       'name': 'file',
	\     },
	\   ],
	\   sourceOptions: #{
	\     _: {
	\       'matchers': ['matcher_substring'],
	\     },
	\   },
	\   kindOptions: #{
	\     file: {
	\       'defaultAction': 'open',
	\     },
	\     help: {
	\       'defaultAction': 'open',
	\     },
	\     action: {
	\       'defaultAction': 'do',
	\     },
	\     lsp: {
	\       'defaultAction': 'do',
	\     },
	\     lsp_codeAction: {
	\       'defaultAction': 'apply',
	\     },
	\   },
	\   uiParams: #{
	\     ff: {
	\       'startFilter': v:false,
	\       'filterSplitDirection': 'botright',
	\       'previewFloating': v:true,
	\       'startAutoAction': v:true,
	\       'autoAction': { 'name': 'preview' },
	\     },
	\     filer: {
	\       'split': 'vertical',
	\       'splitDirection': 'leftabove',
	\       'sortTreesFirst': v:true,
	\     },
	\   },
	\ })

call ddu#custom#patch_local('files', #{
	\   ui: 'filer',
	\   resume: v:true,
	\   sources: [
	\     {
	\       'name': 'file',
	\       'options': {
	\         'columns': ['icon_filename'],
	\       },
	\     },
	\   ],
	\   kindOptions: #{
	\     file: {
	\       'defaultAction': 'open',
	\     },
	\   },
	\ })

call ddu#custom#patch_local('files_rec', #{
	\   sources: [
	\     {
	\       'name': 'file_rec',
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('mr', #{
	\   sources: [
	\     {
	\       'name': 'mr',
	\       'params': { 'kind': 'mrw' },
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('mrr', #{
	\   sources: [
	\     {
	\       'name': 'mr',
	\       'params': { 'kind': 'mrr' },
	\     },
	\   ],
	\   kindOptions: #{
	\     file: {
	\       'defaultAction': 'cd',
	\     },
	\   },
	\ })

call ddu#custom#patch_local('help', #{
	\   sources: [
	\     {
	\       'name': 'help',
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('dpp', #{
	\   sources: [
	\     {
	\       'name': 'dpp',
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('obsidian_note', #{
	\   sources: [
	\     {
	\       'name': 'obsidian_note',
	\       'params': {
	\         'vaults': [
	\           {
	\             'path': $OBSIDIAN_VAULT_REMOTE,
	\             'name': 'remote',
	\           },
	\           {
	\             'path': $OBSIDIAN_VAULT_LOCAL,
	\             'name': 'local',
	\           },
	\         ]
	\       },
	\       'options': {
	\         'matchers': [
	\           'converter_obsidian_rel_path',
  \           'converter_obsidian_title',
  \           'converter_obsidian_vault',
  \           'converter_display_word',
  \           'matcher_kensaku',
	\         ],
	\         'converters': ['converter_obsidian_backlink'],
	\         'sorters': ['sorter_alpha'],
	\       },
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('obsidian_search_task', #{
	\   sources: [
	\     {
	\       'name': 'rg',
	\       'params': {
	\         'input': '- \[ ',
	\         'paths': [
	\           $OBSIDIAN_VAULT_REMOTE,
	\           $OBSIDIAN_VAULT_LOCAL,
	\         ]
	\       },
	\       'options': {
	\         'converters': ['converter_remove_display'],
	\       },
	\     },
	\   ],
	\ })

call ddu#custom#patch_local('lsp_def', #{
	\   sources: [
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>Definition<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduRed",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_definition',
	\       'params': {
	\         'method': 'textDocument/definition',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>typeDefinition<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduLightBlue",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_definition',
	\       'params': {
	\         'method': 'textDocument/typeDefinition',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>declaration<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduYellow",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_references',
	\       'params': {
	\         'method': 'textDocument/declaration',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>Implementation<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduGreen",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_references',
	\       'params': {
	\         'method': 'textDocument/implementation',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\   ],
	\ })


call ddu#custom#patch_local('lsp_ref', #{
	\   sources: [
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>incomingCalls<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduRed",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_callHierarchy',
	\       'params': {
	\         'method': 'callHierarchy/incomingCalls',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>outgoingCalls<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduLightBlue",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_callHierarchy',
	\       'params': {
	\         'method': 'callHierarchy/outgoingCalls',
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\     {
	\       'name': 'dummy',
	\       'params': {
	\         'display': '>>Reference<<',
	\       },
	\       'options': {
	\         'converters': [
	\           #{
	\             name: "converter_highlight",
	\             paramas: #{
	\               hl_group: "DduYellow",
	\             },
	\           }
	\         ]
	\       },
	\     },
	\     {
	\       'name': 'lsp_references',
	\       'params': {
	\         'clientName': 'vim-lsp',
	\       },
	\     },
	\   ],
	\ })


" Keymaps
nnoremap <silent> <Leader>E <Cmd>call ddu#start({'name': 'files'})<CR>
nnoremap <silent> <Leader>ff <Cmd>call ddu#start({'name': 'files_rec'})<CR>
nnoremap <silent> <Leader>hh <Cmd>call ddu#start({'name': 'mr'})<CR>
nnoremap <silent> <Leader>hp <Cmd>call ddu#start({'name': 'mrr'})<CR>
nnoremap <silent> <Leader>zn <Cmd>call ddu#start({'name': 'obsidian_note'})<CR>
nnoremap <silent> <Leader>zT <Cmd>call ddu#start({'name': 'obsidian_search_task'})<CR>
nnoremap <silent> <Leader>fh <Cmd>call ddu#start({'name': 'help'})<CR>
nnoremap <silent> <Leader>fd <Cmd>call ddu#start({'name': 'dpp'})<CR>
nnoremap <silent> gs <Cmd>call ddu#start({'name': 'lsp_ref'})<CR>
nnoremap <silent> gd <Cmd>call ddu#start({'name': 'lsp_def'})<CR>

" Buf keymaps
function! s:ddu_keymaps() abort
  nnoremap <buffer> <silent> i <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer> <silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> <silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
  nnoremap <buffer> <silent> p <Cmd>call ddu#ui#do_action('preview')<CR><Esc>
  nnoremap <buffer> <silent> a <Cmd>call ddu#ui#do_action('chooseAction')<CR><Esc>
  nnoremap <buffer> <silent> t <Cmd>call ddu#ui#do_action('itemAction', { 'name': 'open', 'params': { 'command': 'tabedit' }})<CR><Esc>
endfunction

function! s:ddu_filter_keymaps() abort
  inoremap <buffer> <silent> <CR> <Cmd>call ddu#ui#do_action('closeFilterWindow')<CR><Esc>
  inoremap <buffer> <silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
endfunction

function! s:ddu_filer_keymaps() abort
  nnoremap <buffer> <silent> <C-c> <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
  nnoremap <buffer> <silent> a <Cmd>call ddu#ui#do_action('chooseAction')<CR><Esc>
  nnoremap <buffer> <silent> l <Cmd>call ddu#ui#do_action('expandItem')<CR><Esc>
  nnoremap <buffer> <silent> h <Cmd>call ddu#ui#do_action('collapseItem')<CR><Esc>
  nnoremap <buffer> <silent> <CR> <Cmd>call ddu#ui#do_action('itemAction')<CR><Esc>
  nnoremap <buffer> <silent> p <Cmd>call ddu#ui#do_action('preview')<CR><Esc>
endfunction

autocmd FileType ddu-ff call s:ddu_keymaps()
autocmd FileType ddu-ff-filter call s:ddu_filter_keymaps()
autocmd FileType ddu-filer call s:ddu_filer_keymaps()
