" コピー系
nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
nnoremap <Leader>r diw"0P

" ウィンドウ操作系
nnoremap <Leader>o <C-w><C-w>
nnoremap <Leader>ss <C-w>s
nnoremap <Leader>sv <C-w>v

" 移動系
inoremap <C-b> <LEFT>
inoremap <C-f> <RIGHT>
noremap H ^
noremap L $

" 特殊
nnoremap <Leader>_ :source $MYVIMRC<CR>

" ファイル操作
nnoremap <Leader>w :w<CR>
