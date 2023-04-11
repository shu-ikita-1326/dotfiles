let g:fzf_preview_directory_files_command = 'rg --files --hidden --follow --no-messages -g "!{**/.git/*}"'
augroup fzf
	autocmd!
	autocmd FileType fzf call s:fzf_settings()
	function! s:fzf_settings() abort
		tnoremap <buffer><silent> <C-c> <Esc>
	endfunction
augroup END

nnoremap <silent> <Leader>ff :FzfPreviewDirectoryFilesRpc<CR>
nnoremap <silent> <Leader>h :FzfPreviewMruFilesRpc<CR>
nnoremap <silent> <Leader>fb :FzfPreviewAllBuffersRpc<CR>
