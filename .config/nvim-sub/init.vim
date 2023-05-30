set number
set nobackup
set nowritebackup
set virtualedit=block

set undofile
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
set title
set noswapfile
set ambiwidth=single

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" keymap
let mapleader = " "
nnoremap <Leader>_ :source $MYVIMRC<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o <C-w><C-w>
nnoremap J 5j
nnoremap K 5k
vnoremap J 5j
vnoremap K 5k
nnoremap <Leader>P "0P
nnoremap <Leader>p "0p
nnoremap <Leader>r ciw<C-r>0<Esc>b

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

let s:dein_base = '~/.cache/dein/'

" Set dein source path (required)
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

" Set dein runtime path (required)
execute 'set runtimepath+=' .. s:dein_src
execute 'set runtimepath+=' .. '/home/linuxbrew/.linuxbrew/bin'

" Call dein initialization (required)
call dein#begin(s:dein_base)
call dein#load_toml($HOME . '/.config/nvim-sub/dein/dein.toml')

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

