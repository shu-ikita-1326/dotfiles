set encoding=utf-8
" show line numbers
set number

" Change Leader key to space
let mapleader = "\<Space>"

" don't create swap file
set noswapfile

" Automatically hide when opening another buffer
set hidden

" mute beep
set belloff=all

" Convert tabs to two spaces
set softtabstop=2
set tabstop=2

set shiftwidth=2

" Create an undo file in ~/.vim/undo/
set undofile

let s:undodir='~/.cache/vim/undo/'
function! s:init_undofile_dir()
  if !isdirectory(expand(s:undodir))
    call mkdir(expand(s:undodir), 'p')
  endif
endfunction
call s:init_undofile_dir()

set undodir=~/.cache/vim/undo/ 

" Search system
" If the search string is a lowercase letter, search is performed without distinguishing between uppercase and lowercase letters.
set ignorecase
" If the search string contains uppercase letters, search separately.
set smartcase
" Search incrementally when searching
set incsearch
" When you reach the end, go back to the beginning
set wrapscan
" Highlight search string
set hlsearch
" Delete the highlight with Leader + n
noremap <silent><Leader>n :noh<CR>

filetype on

" Cursor shape control in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Return to half-width input when exiting insert mode
" Enter the path of the zenhan executable file on the windows side in the zenhan environment variable.
if exists('$zenhan')
	let &shell='/usr/bin/zsh --login'
	augroup zenhan
					autocmd!
					autocmd InsertLeave * :call system("${zenhan} 0")
					autocmd CmdlineLeave * :call system("${zenhan} 0")
	augroup END
endif

" Keymap so that InsertLeave hooks with ctrl + c
inoremap <C-c> <C-[>
inoremap <C-[> <C-c>
