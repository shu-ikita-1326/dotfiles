call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('autoCompleteEvents',
			\ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter'])
nnoremap : <Cmd>call CommandlinePre()<CR>:
nnoremap / <Cmd>call CommandlinePre()<CR>/
nnoremap ? <Cmd>call CommandlinePre()<CR>?

function! CommandlinePre() abort
	cnoremap <Nul> <Cmd>call ddc#map#manual_complete()<CR>
	cnoremap <expr> <C-p> pum#visible() ? pum#map#insert_relative(-1) : "<Up>"
	cnoremap <expr> <C-n> pum#visible() ? pum#map#select_relative(+1) : "<Down>"
	cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
	cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

	" Overwrite sources
	if !exists('b:prev_buffer_config')
		let b:prev_buffer_config = ddc#custom#get_buffer()
	endif
	call ddc#custom#patch_buffer('sources',
				\ ['cmdline', 'cmdline-history', 'around'])

	autocmd User DDCCmdlineLeave ++once call CommandlinePost()
	autocmd InsertEnter <buffer> ++once call CommandlinePost()

	" Enable command line completion
	call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
	silent! cunmap <Tab>
	silent! cunmap <S-Tab>
	silent! cunmap <C-n>
	silent! cunmap <C-p>
	silent! cunmap <C-y>
	silent! cunmap <C-e>

	" Restore sources
	if exists('b:prev_buffer_config')
		call ddc#custom#set_buffer(b:prev_buffer_config)
		unlet b:prev_buffer_config
	else
		call ddc#custom#set_buffer({})
	endif
endfunction
call ddc#custom#patch_global('cmdlineSources', {
			\   ':': ['cmdline-history', 'cmdline'],
			\   '@': ['cmdline-history', 'around'],
			\   '>': ['cmdline-history', 'around'],
			\   '/': ['buffer', 'around'],
			\   '?': ['around'],
			\   '-': ['around'],
			\   '=': [],
			\ })

call ddc#custom#patch_global('sources', ['vim-lsp', 'buffer', 'cmdline'])

call ddc#custom#patch_global('sourceOptions', {
			\ '_': {
			\   'matchers': ['matcher_fuzzy'],
			\   'sorters': ['sorter_fuzzy'],
			\   'converters': ['converter_fuzzy'],
			\ },
			\ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
			\ 'around': {'mark': 'A'},
			\ })
call ddc#custom#patch_global('sourceOptions', {
			\ 'buffer': {'mark': 'Buf'},
			\ })
call ddc#custom#patch_global('sourceOptions', {
			\ 'vim-lsp': {'mark': 'Lsp',
			\ 'matchers':['matcher_head'],
			\ }
			\ })
call ddc#custom#patch_global('sourceParams', {
			\ 'around': {'maxSize': 500},
			\ })
call ddc#custom#patch_global('sourceOptions', #{
			\ cmdline: #{
			\ mark: 'cmdline',
			\ },
			\ file: #{
			\   mark: 'F',
			\   isVolatile: v:true,
			\   minAutoCompleteLength: 1000,
			\   forceCompletionPattern: '\S/\S*',
			\ },
			\ cmdline-history: #{
			\   mark: 'history',
			\   sorters: [],
			\ },
			\ })

" Customize settings on a filetype
call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
			\ 'clangd': {'mark': 'C'},
			\ })
call ddc#custom#patch_filetype('markdown', 'sourceParams', {
			\ 'around': {'maxSize': 100},
			\ })
" Use ddc.
call ddc#enable()

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
			\ pumvisible() ? '<C-n>' :
			\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
			\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
inoremap <Nul> <Cmd>call ddc#map#manual_complete()<CR>
