let s:jetpackfile = expand('~/.vim') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'

let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
	call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
call jetpack#add('lambdalisue/fern-git-status.vim')
call jetpack#add('lambdalisue/nerdfont.vim')
call jetpack#add('lambdalisue/fern-renderer-nerdfont.vim')
call jetpack#add('lambdalisue/fern.vim',
			\ {'depends': ['lambdalisue/fern-renderer-nerdfont.vim', 'lambdalisue/nerdfont.vim', 'lambdalisue/fern-git-status.vim'],
			\ 'hook_add': 'source ~/.vim/rc/config/fern.vim'})
call jetpack#add('junegunn/fzf', {'build': './install'})
call jetpack#add('dracula/vim')
call jetpack#add('tpope/vim-surround')
call jetpack#add('machakann/vim-highlightedyank', {'hook_add': 'let g:highlightedyank_highlight_duration = 300'})
call jetpack#add('tpope/vim-commentary')
call jetpack#add('skanehira/translate.vim', {'hook_add': 'source ~/.vim/rc/config/translate.vim'})
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('vim-airline/vim-airline', {'hook_post_source': 'let g:airline#extensions#tabline#enabled = 1'})
call jetpack#add('jiangmiao/auto-pairs')
call jetpack#add('tpope/vim-fugitive')
call jetpack#add('airblade/vim-gitgutter')
call jetpack#add('voldikss/vim-floaterm', {'hook_add': 'source ~/.vim/rc/config/vim-floaterm.vim'})
call jetpack#add('vim-denops/denops.vim')
call jetpack#add('Shougo/ddc-around', {'on_source': 'ddc.vim'})
call jetpack#add('Shougo/ddc-ui-native', {'on_source': 'ddc.vim'})
call jetpack#add('Shougo/ddc-ui-pum', {'on_source': 'ddc.vim'})
call jetpack#add('Shougo/ddc-source-around', {'on_source': 'ddc.vim'})
call jetpack#add('Shougo/ddc-matcher_head', {'on_source': 'ddc.vim'})
call jetpack#add('Shougo/ddc-sorter_rank', {'on_source': 'ddc.vim'})
call jetpack#add('shun/ddc-vim-lsp', {'on_source': 'ddc.vim'})
call jetpack#add('matsui54/ddc-buffer')
call jetpack#add('Shougo/ddc-source-cmdline')
call jetpack#add('Shougo/ddc-source-cmdline-history')
call jetpack#add('tani/ddc-fuzzy')
call jetpack#add('Shougo/pum.vim', {'hook_post_source': 'source ~/.vim/rc/config/pum.vim'})
call jetpack#add('Shougo/ddc.vim',
			\ {'depends': ['denops.vim', 'pum.vim'], 
			\ 'hook_post_source': 'source ~/.vim/rc/config/ddc.vim'})
call jetpack#add('Shougo/ddu-ui-ff', {'on_source': 'ddu.vim'})
call jetpack#add('Shougo/ddu-kind-file', {'on_source': 'ddu.vim'})
call jetpack#add('Shougo/ddu-source-file_rec', {'on_source': 'ddu.vim'})
call jetpack#add('Shougo/ddu-source-file_old', {'on_source': 'ddu.vim'})
call jetpack#add('Shougo/ddu-filter-matcher_substring', {'on_source': 'ddu.vim'})
call jetpack#add('yuki-yano/ddu-filter-fzf', {'on_source': 'ddu.vim'})
call jetpack#add('Shougo/ddu.vim',
			\ {'depends': ['denops.vim'], 
			\ 'hook_post_source': 'source ~/.vim/rc/config/ddu.vim'})
call jetpack#add('prabirshrestha/vim-lsp', {'hook_post_source': 'source ~/.vim/rc/config/vim-lsp.vim'})
call jetpack#add('mattn/vim-lsp-settings')
call jetpack#add('yuki-yano/fzf-preview.vim', {'branch': 'release/rpc', 'hook_post_source': 'source ~/.vim/rc/config/fzf-preview.vim'})
call jetpack#add('')
call jetpack#add('')
call jetpack#end()

let g:denops_server_addr = '127.0.0.1:32123'
let s:denops_path = jetpack#get('denops.vim').path

call job_start(
			\   'deno run -A --no-check ' . s:denops_path . '/denops/@denops-private/cli.ts',
			\   {'stoponexit': ''}
			\)

for name in jetpack#names()
	if !jetpack#tap(name)
		call jetpack#sync()
		break
	endif
endfor
