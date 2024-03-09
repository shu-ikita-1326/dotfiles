noremap <silent> <Leader>e <Cmd>Fern . -drawer<CR>
noremap <silent> <Leader>b <Cmd>Fern . -drawer<CR>
let g:fern#default_hidden=1
let g:fern#renderer="nerdfont"

let g:fern#disable_default_mappings=1

function s:fern_custom_map()
  set nonumber
  noremap <buffer> H <Plug>(fern-action-hidden:toggle)
  noremap <buffer> l <Plug>(fern-action-open-or-expand)
  noremap <buffer> h <Plug>(fern-action-collapse)
  noremap <buffer> a <Plug>(fern-action-new-file)
endfunction

augroup MyFernInit
  au! *
  au FileType fern call s:fern_custom_map()
augroup END
