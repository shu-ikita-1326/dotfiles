function! Myterm()
	split
	wincmd j
	resize 10
	terminal
	wincmd k
endfunction

command! Myterm call Myterm()
