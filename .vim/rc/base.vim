" 行番号を表示
set number

" Leaderキーをスペースに変更
let mapleader = "\<Space>"

" スワップファイルを作らない
set noswapfile

" 別のバッファを開くときに自動でhideする
set hidden

" ビープ音を消す
set belloff=all

" タブをスペース二つに変換
set softtabstop=2
set tabstop=2

" undoファイルを~/.vim/undo/に作成する
set undofile

let s:undodir='~/.cache/vim/undo/'
function! s:init_undofile_dir()
  if !isdirectory(expand(s:undodir))
    call mkdir(expand(s:undodir), 'p')
  endif
endfunction
call s:init_undofile_dir()

set undodir=~/.cache/vim/undo/ 

" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別せず検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索時インクリメンタルに検索する
set incsearch
" 最後まで行ったら最初に戻る
set wrapscan
" 検索文字列をハイライト
set hlsearch
" Leader + nでハイライトを消す
noremap <silent><Leader>n :noh<CR>

filetype on

" インサートモードのカーソル形状制御
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" インサートモードから抜けたときに半角入力に戻す
" 環境変数zenhanにwindows側のzenhan実行ファイルのpathを記入しておく
if exists('$zenhan')
	let &shell='/usr/bin/zsh --login'
	autocmd InsertLeave * :call system("${zenhan} 0")
	autocmd CmdlineLeave * :call system("${zenhan} 0")
endif

" ctrl + cでInsertLeaveがフックするようにキーマップ
inoremap <C-c> <C-[>
inoremap <C-[> <C-c>
