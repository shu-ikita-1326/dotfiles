call skkeleton#config(#{
	\   eggLikeNewline: v:true,
	\   registerConvertResult: v:true,
	\   globalDictionaries: ['~/.local/share/nvim/lazy/dict/SKK-JISYO.L'->expand()],
	\ })

inoremap <C-j> <Plug>(skkeleton-toggle)
cnoremap <C-j> <Plug>(skkeleton-toggle)
tnoremap <C-j> <Plug>(skkeleton-toggle)
