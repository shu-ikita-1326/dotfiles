let $CACHE = expand('~/.cache')
if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif
if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/nvim-sub/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif

let s:dein_base = '~/.cache/nvim-sub/dein/'

" Set dein source path (required)
let s:dein_src = '~/.cache/nvim-sub/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path (required)
execute 'set runtimepath+=' .. s:dein_src
execute 'set runtimepath+=' .. '/home/linuxbrew/.linuxbrew/bin'

" Call dein initialization (required)
call dein#begin(s:dein_base)
call dein#load_toml($HOME . '/.config/nvim-sub/dein/dein.toml')
call dein#load_toml($HOME . '/.config/nvim-sub/dein/ddu.toml')
call dein#load_toml($HOME . '/.config/nvim-sub/dein/ddc.toml')

call dein#add(s:dein_src)
call dein#end()

if dein#check_install()
  call dein#install()
endif

let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
  call map(s:removed_plugins, "delete(v:val, 'rf')")
  call dein#recache_runtimepath()
endif
