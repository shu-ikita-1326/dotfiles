let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

let s:dein_base = $CACHE .. '/dein/'

let s:dein_src = s:dein_base .. 'repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' .. s:dein_src

call dein#begin(s:dein_base)

call dein#add(s:dein_src)

call dein#load_toml(expand('~/.vim/dein.toml'))

call dein#end()

