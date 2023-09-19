scriptencoding utf-8
" ui settings
highlight PumUiSBar guifg=yellow
function! s:pum_set_option() abort
  call pum#set_option({
    \   'auto_confirm_time': 0,
    \   'horizontal_menu': v:false,
    \   'max_width': min([(&columns / 3), 50]),
    \   'max_height': (&lines / 3),
    \   'use_setline': v:false,
    \   'border': 'rounded',
    \   'scrollbar_char': '┃',
    \   'highlight_scrollbar': 'PumUiSBar',
    \   'preview': v:true,
    \   'preview_border': 'rounded',
    \   'preview_height': (&lines / 2),
    \   'preview_width': (&columns / 3),
    \ })
endfunction

call s:pum_set_option()

augroup MyAutoCmd
  autocmd VimResized * call s:pum_set_option()
augroup END

" global settings
call ddc#custom#patch_global({
      \   'ui': 'pum',
      \   'cmdlineSources': {
      \     ':': ['cmdline', 'cmdline-history', 'file', 'around'],
      \     '@': ['cmdline-history', 'input', 'file', 'around'],
      \     '>': ['cmdline-history', 'input', 'file', 'around'],
      \     '/': ['around'],
      \     '?': ['around'],
      \     '-': ['around'],
      \     '=': ['input'],
      \   },
      \   'sources': ['vsnip', 'nvim-lsp', 'around', 'cmdline'],
      \   'sourceOptions': {
      \     '_': {
      \       'matchers': ['matcher_fuzzy'],
      \       'sorters': ['sorter_fuzzy'],
      \       'converters': ['converter_fuzzy'],
      \       'ignoreCase': v:true,
      \     },
      \     'around': {'mark': '[around]'},
      \     'nvim-lsp': {
      \       'mark': '[Lsp]',
      \     },
      \     'cmdline': {'mark': '[cmdline]'},
      \     'vsnip': {'mark': '[vsnip]'},
      \     'file': {
      \       'mark': '[file]',
      \       'isVolatile': v:true,
      \       'minAutoCompleteLength': 1000,
      \       'forceCompletionPattern': '\S/\S*',
      \     },
      \     'cmdline-history': {
      \       'mark': '[history]',
      \       'sorters': [],
      \     },
      \   },
      \   'sourceParams': {
      \     'nvim-lsp': {
      \       'snippetEngine': denops#callback#register({
      \         body -> vsnip#anonymous(body)
      \       }),
      \       'enableResolveItem': v:true,
      \       'enableAdditionalTextEdit': v:true,
      \       'confirmBehavior': 'replace',
      \     },
      \   },
      \   'autoCompleteEvents': ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter'],
      \ })

call ddc#custom#patch_filetype(['vim'], {
      \   'cmdlineSources': {
      \     ':': ['cmdline', 'file', 'around'],
      \     '@': ['cmdline-history', 'input', 'file', 'around'],
      \     '>': ['cmdline-history', 'input', 'file', 'around'],
      \     '/': ['around'],
      \     '?': ['around'],
      \     '-': ['around'],
      \     '=': ['input'],
      \   },
      \ })

function! CommandlinePre() abort
  cnoremap <C-i>   <Up>
  cnoremap <C-k>   <Down>
  cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  cnoremap <C-Space>   <Cmd>call ddc#map#manual_complete()<CR>

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
augroup MyAutoCmd
  autocmd User DDCCmdlineLeave ++once call CommandlinePost()
augroup END

  " Enable command line completion
call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
  silent! cunmap <C-k>
  silent! cunmap <C-i>
  silent! cunmap <C-n>
  silent! cunmap <C-p>
  silent! cunmap <C-y>
  silent! cunmap <C-e>
  silent! cunmap <C-Space>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction

nnoremap : <Cmd>call CommandlinePre()<CR>:
inoremap <silent> <C-Space> <Cmd>call ddc#map#manual_complete()<CR>
call ddc#enable()

inoremap <C-n> <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <C-o> <Cmd>call pum#map#confirm_word()<CR>
inoremap <C-e> <Cmd>call pum#map#cancel()<CR>
