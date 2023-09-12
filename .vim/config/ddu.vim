call ddu#custom#patch_global({
			\   'ui': 'ff',
			\   'sources': [{'name': 'file_rec', 'params': {}}],
			\   'sourceOptions': {
			\     '_': {
			\       'matchers': ['matcher_fzf'],
			\     },
			\   },
			\   'kindOptions': {
			\     'file': {
			\       'defaultAction': 'open',
			\     },
			\   },
			\   'uiParams': {
			\     'ff': {
			\       'startFilter': v:true,
			\     },
			\   },
			\	})

" For history search
let historyOption = {
			\ 'ui': 'ff',
			\ 'sources': [{'name': 'file_old', 'params': {}}],
			\ 'sourceOptions': {
			\   '_': {
			\     'matchers': ['matcher_fzf'],
			\   },
			\ },
			\ 'kindOptions': {
			\   'file': {
			\     'defauiltAction': 'open',
			\   },
			\ },
			\ 'uiParams': {
			\   'ff': {
			\     'startFilter': v:true,
			\   },
			\ },
			\}


" Mappings
nnoremap <Leader>fd :call ddu#start({})<CR>
nnoremap <Leader>fh :call ddu#start(historyOption)<CR>

augroup MyAutoCmd
  autocmd FileType ddu-ff call s:ddu_my_settings()
augroup END

function! s:ddu_my_settings() abort
	setlocal cursorline
	nnoremap <buffer> <CR>
				\ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	nnoremap <buffer> i
				\ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
	nnoremap <buffer> q
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
	nnoremap <buffer> <C-c>
				\ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

augroup MyAutoCmd
  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
augroup END

function! s:ddu_filter_my_settings() abort
	inoremap <buffer> <CR>
				\ <Esc><Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
	inoremap <buffer> <C-c>
				\ <Esc><Cmd>call ddu#ui#ff#do_action('quit')<CR>
	inoremap <buffer> <C-n>
				\ <Cmd>call win_execute(ddu#ui#winid('default'), ['call setpos(".", [0, getcurpos()[1] + 1, 1, 0])', 'redraw'])<CR>
	inoremap <buffer> <C-p>
				\ <Cmd>call win_execute(ddu#ui#winid('default'), ['call setpos(".", [0, getcurpos()[1] - 1, 1, 0])', 'redraw'])<CR>
endfunction
