let g:fern#default_hidden = 1
let g:fern#renderer = "nerdfont"
let g:fern#disable_default_mappings = 1

nnoremap <silent><Leader>e :Fern . -drawer<CR>
nnoremap <silent><Leader>b :Fern . -drawer -toggle<CR>

" keymapping
function! s:fern_my_keymap() abort
nnoremap <silent> <buffer> H <Plug>(fern-action-hidden:toggle)<CR>
nnoremap <silent> <buffer> l <Plug>(fern-action-expand:stay)<CR>
nnoremap <silent> <buffer> h <Plug>(fern-action-collapse)<CR>
nnoremap <silent> <buffer> . <Plug>(fern-action-cd:cursor)<CR>
nnoremap <silent> <buffer> a <Plug>(fern-action-new-path)<CR>
nnoremap <silent> <buffer> d <Plug>(fern-action-remove)<CR>
nnoremap <silent> <buffer> <BS> <Plug>(fern-action-cd:root)<CR>
nnoremap <silent> <buffer> y <Plug>(fern-action-clipboard-copy)<CR>
nnoremap <silent> <buffer> m <Plug>(fern-action-clipboard-move)<CR>
nnoremap <silent> <buffer> p <Plug>(fern-action-clipboard-paste)<CR>
nnoremap <silent> <buffer> r <Plug>(fern-action-rename)<CR>
endfunction

augroup fern_group
	autocmd!
	autocmd QuitPre :Fern . -drawer -toggle<CR>
	autocmd FileType fern setlocal nonumber
	autocmd FileType fern setlocal signcolumn=no
	autocmd FileType fern call s:fern_my_keymap()
augroup END

