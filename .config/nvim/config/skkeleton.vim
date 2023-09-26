imap <C-k> <Plug>(skkeleton-toggle)
cmap <C-k> <Plug>(skkeleton-toggle)
tmap <C-k> <Plug>(skkeleton-toggle)
call skkeleton#config({
      \  'eggLikeNewline': v:true,
      \  'registerConvertResult': v:true,
      \})

call add(g:skkeleton#mapped_keys, '<C-l>')
call skkeleton#register_keymap('input', "<C-l>", 'katakana')

