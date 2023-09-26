let g:rotated_index = 0
function! RotateYank(event) abort
  let s:registers = ['a', 'b', 'c', 'd', 'e', 'f', 'g']
  let s:contents = a:event.regcontents
  echom s:registers[g:rotated_index]
  call setreg(s:registers[g:rotated_index], s:contents)
  let g:rotated_index = g:rotated_index + 1
  if g:rotated_index >= len(s:registers)
    let g:rotated_index = 0
  endif
endfunction

autocmd TextYankPost * call RotateYank(v:event)

if exists("g:neovide")
  augroup neovide_startup
    autocmd! VimEnter * cd ~
  augroup END
endif
