vim9script

g:fern#default_hidden = 1
g:fern#renderer = "nerdfont"

nnoremap <silent><Leader>e :Fern . -drawer<CR>
nnoremap <silent><Leader>b :Fern . -drawer -toggle<CR>

augroup fern_group
	autocmd!
	autocmd QuitPre :Fern . -drawer -toggle<CR>
	autocmd FileType fern setlocal nonumber
augroup END
