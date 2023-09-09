let g:fern#default_hidden = 1
let g:fern#renderer = "nerdfont"
let g:fern#disable_default_mappings = 1

nnoremap <silent><Leader>e :Fern . -drawer<CR>
nnoremap <silent><Leader>b :Fern . -drawer -toggle<CR>

" keymapping
function! s:fern_my_keymap() abort
nnoremap <buffer> <BS> <Plug>(fern-action-leave)
nnoremap <buffer> H <Plug>(fern-action-hidden:toggle)
nnoremap <buffer> l <Plug>(fern-action-open-or-expand)
nnoremap <buffer> h <Plug>(fern-action-collapse)
nnoremap <buffer> <CR> <Plug>(fern-action-open-or-enter)
nnoremap <buffer> A <Plug>(fern-action-new-path)
nnoremap <buffer> d <Plug>(fern-action-remove)
nnoremap <buffer> y <Plug>(fern-action-clipboard-copy)
nnoremap <buffer> m <Plug>(fern-action-clipboard-move)
nnoremap <buffer> p <Plug>(fern-action-clipboard-paste)
nnoremap <buffer> r <Plug>(fern-action-rename)
nnoremap <buffer> R <Plug>(fern-action-redraw)
nnoremap <buffer> <CR> <Plug>(fern-action-open-or-expand)
endfunction

augroup fern_group
	autocmd!
	autocmd QuitPre :Fern . -drawer -toggle<CR>
	autocmd FileType fern setlocal nonumber
	autocmd FileType fern setlocal signcolumn=no
	autocmd FileType fern call s:fern_my_keymap()
augroup END

