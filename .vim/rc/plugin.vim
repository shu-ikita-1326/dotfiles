let s:jetpackfile = expand('~/.vim') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
call jetpack#load_toml(expand('~/.vim/plugins/common.toml'))
call jetpack#add('tani/vim-jetpack', {'opt': 1}) "bootstrap
call jetpack#add('junegunn/fzf', {'build': './install'}) "bootstrap
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
