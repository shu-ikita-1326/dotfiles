call ddc#custom#patch_global(#{
	\   ui: 'pum',
	\   sources: ['denippet', 'around', 'cmdline', 'dictionary', 'skkeleton'],
	\   sourceOptions: #{
	\     _: #{
	\       matchers: ['matcher_fuzzy'],
	\       sorters: ['sorter_fuzzy'],
	\       converters: ['converter_fuzzy'],
	\       ignoreCase: v:true,
	\     },
	\     around: #{
	\       mark: '[around]',
	\     },
	\     cmdline: #{
	\       mark: '[cmdline]',
	\     },
	\     skkeleton: #{
	\       mark: '[skk]',
	\       matchers: ['skkeleton'],
	\       sorters: [],
	\       isVolatile: v:true,
	\     },
	\     dictionary: #{
	\       mark: '[dict]',
	\     },
	\     denippet: #{
	\       mark: '[denippet]',
	\     },
	\   },
	\   sourceParams: #{
	\     dictionary: #{
	\       paths: [
	\         dpp#get('english-words')['path'] .. "/words.txt",
	\       ],
	\       firstCaseInsensitive: v:true,
	\     },
	\   },
	\   autoCompleteEvents: ['InsertEnter', 'TextChangedI', 'TextChangedP'],
	\ })

inoremap <silent> <C-n> <Cmd>call pum#map#insert_relative(1)<CR>
inoremap <silent> <C-p> <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <silent> <C-y> <Cmd>call pum#map#confirm()<CR>
inoremap <silent> <C-g> <Cmd>call pum#map#cancel()<CR>
inoremap <silent> <C-Space> <Cmd>call pum#map#manual_complete()<CR>

call ddc#enable()
