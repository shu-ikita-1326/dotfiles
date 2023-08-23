" global settings
call ddc#custom#patch_global(#{
      \   ui: 'pum',
      \   cmdlineSources: {
      \     ':': ['cmdline', 'cmdline-history', 'file', 'around'],
      \     '@': ['cmdline-history', 'input', 'file', 'around'],
      \     '>': ['cmdline-history', 'input', 'file', 'around'],
      \     '/': ['around'],
      \     '?': ['around'],
      \     '-': ['around'],
      \     '=': ['input'],
      \   },
      \   sources: ['vsnip', 'nvim-lsp', 'around', 'cmdline'],
      \   sourceOptions: #{
		  \     _: #{
		  \       matchers: ['matcher_fuzzy'],
		  \       sorters: ['sorter_fuzzy'],
		  \       converters: ['converter_fuzzy'],
		  \       ignoreCase: v:true,
		  \     },
		  \     around: #{mark: '[around]'},
		  \     nvim-lsp: #{mark: '[Lsp]'},
		  \     cmdline: #{mark: '[cmdline]'},
		  \     vsnip: #{mark: '[vsnip]'},
		  \     file: #{
		  \       mark: '[file]',
		  \       isVolatile: v:true,
		  \       minAutoCompleteLength: 1000,
		  \       forceCompletionPattern: '\S/\S*',
		  \     },
		  \     cmdline-history: #{
		  \       mark: '[history]',
		  \       sorters: [],
		  \     },
      \   },
      \   autoCompleteEvents: ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter'],
      \ })


function! CommandlinePre() abort
  cnoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
  cnoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  cnoremap <C-Space>   <Cmd>call ddc#map#manual_complete()<CR>

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  " Enable command line completion
call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
  silent! cunmap <C-n>
  silent! cunmap <C-p>
  silent! cunmap <C-y>
  silent! cunmap <C-e>
  silent! cunmap <C-Space>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif
endfunction

nnoremap : <Cmd>call CommandlinePre()<CR>:
inoremap <silent> <C-Space> <Cmd>call ddc#map#manual_complete()<CR>
call ddc#enable()
