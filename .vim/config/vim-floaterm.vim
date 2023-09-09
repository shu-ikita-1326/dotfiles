augroup floaterm
	autocmd!
	autocmd FileType floaterm call s:floaterm_settings()
	function! s:floaterm_settings() abort
		tnoremap <buffer><silent> <C-c> <C-\><C-n>:FloatermHide<CR>
	endfunction
	autocmd QuitPre * FloatermKill!
	autocmd VimEnter * FloatermNew --height=0.9 --width=0.9 --silent --name=lazygit lazygit
augroup END

nnoremap <silent> <Leader>lg :FloatermShow lazygit<CR>
