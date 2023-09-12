call pum#set_option({
			\   'auto_confirm_time': 3000,
			\   'horizontal_menu': v:false,
			\   'max_height': 10,
			\   'max_width': 80,
			\   'use_setline': v:false,
			\ })
call pum#set_local_option('c', {
			\   'horizontal_menu': v:false,
			\ })
inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
