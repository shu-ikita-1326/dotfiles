set nocompatible

const s:dpp_base = '~/.cache/dpp/'->expand()
const s:dpp_repo_dir = '~/.cache/dpp/repos/github.com/'->expand()
const s:plugin_host = 'https://github.com/'

function! s:init_plugin(plugin) abort
  const dir = s:dpp_repo_dir .. a:plugin
  if !dir->isdirectory()
    call system('git clone ' .. s:plugin_host .. a:plugin .. ' ' .. dir)
    echo 'cloned ' .. s:dpp_repo_dir .. a:plugin
  endif

  execute 'set runtimepath^=' .. dir
endfunction

function! DppMakeState() abort
  call dpp#make_state(s:dpp_base, '~/.vim/rc/plugin/dpp.ts'->expand())
endfunction

call s:init_plugin('Shougo/dpp.vim')
call s:init_plugin('Shougo/dpp-ext-lazy')
call s:init_plugin('Shougo/dpp-ext-installer')
call s:init_plugin('Shougo/dpp-ext-local')
call s:init_plugin('Shougo/dpp-ext-toml')
call s:init_plugin('Shougo/dpp-protocol-git')
call s:init_plugin('vim-denops/denops.vim')


if s:dpp_base->dpp#min#load_state()
  for plugin in [
        \   'Shougo/dpp-ext-installer',
        \   'Shougo/dpp-ext-local',
        \   'Shougo/dpp-ext-packspec',
        \   'Shougo/dpp-ext-toml',
        \   'Shougo/dpp-protocol-git',
        \ ]
    call s:init_plugin(plugin)
  endfor

  augroup MyAutoCmd
    autocmd MyAutoCmd User DenopsReady
          \ : echohl WarningMsg
          \ | echomsg 'dpp load_state() is failed'
          \ | echohl NONE
          \ | call DppMakeState()
  augroup END
else
  augroup MyAutoCmd
    autocmd MyAutoCmd BufWritePost *.lua,*.vim,*.toml,*.ts,vimrc,.vimrc
          \ call dpp#check_files()
  augroup END
endif

augroup MyAutoCmd
  autocmd MyAutoCmd User Dpp:makeStatePost
        \ : echohl WarningMsg
        \ | echomsg 'dpp load_state() is done'
        \ | echohl NONE
augroup END
