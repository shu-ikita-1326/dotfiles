let g:floaterm_width = 0.9
let g:floaterm_height = 0.9

nnoremap <silent> <C-\><C-\> <Cmd>FloatermToggle<CR>
tnoremap <silent> <C-\><C-\> <Cmd>FloatermToggle<CR>

nnoremap <silent> <Leader>lg <Cmd>FloatermNew lazygit<CR>
nnoremap <silent> <Leader>ld <Cmd>FloatermNew lazydocker<CR>

function! s:kill_floaterm() abort
	let win_info = getwininfo()
  if win_info->len() == 1
    FloatermKill!
  endif
endfunction

augroup my_floaterm
  autocmd! *
	autocmd QuitPre * call s:kill_floaterm()
augroup END
