noremap <silent> <Leader>e <Cmd>Fern . -drawer -toggle<CR>
let g:fern#default_hidden=1
let g:fern#renderer="nerdfont"

let g:fern#disable_default_mappings=1

function s:fern_custom_map()
  set nonumber
  set nowrap
  noremap <buffer> ! <Plug>(fern-action-hidden:toggle)
  noremap <buffer> l <Plug>(fern-action-open-or-expand)
  noremap <buffer> h <Plug>(fern-action-collapse)
  noremap <buffer> N <Plug>(fern-action-new-file)
  noremap <buffer> Nd <Plug>(fern-action-new-dir)
  noremap <buffer> H <Cmd>cd ../<CR><Cmd>Fern . -drawer<CR>
  noremap <buffer> L <Plug>(fern-action-cd:cursor)<Cmd>Fern . -drawer<CR>
  noremap <buffer> y <Plug>(fern-action-clipboard-copy)
  noremap <buffer> m <Plug>(fern-action-clipboard-move)
  noremap <buffer> p <Plug>(fern-action-clipboard-paste)
  noremap <buffer> <C-c> <Plug>(fern-action-clipboard-clear)
  noremap <buffer> <Tab> <Plug>(fern-action-mark:toggle)
  noremap <buffer> d <Plug>(fern-action-remove)
endfunction

augroup MyFernInit
  au! *
  au FileType fern call s:fern_custom_map()
augroup END
