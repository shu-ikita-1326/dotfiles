let g:translate_endpoint = 'https://api-free.deepl.com/v2/translate'
let g:translate_ui = 'buffer'

nnoremap <silent> <Leader>tl :Translate<CR>
vnoremap <silent> <Leader>tl :Translate<CR>
nnoremap <silent> <Leader>tle :Translate!<CR>
vnoremap <silent> <Leader>tle :Translate!<CR>
