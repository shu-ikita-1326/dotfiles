call ddu#custom#patch_global({
		\  'ui': 'ff',
		\  'sources': [{'name': 'file_rec', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'kindOptions': {
		\    'file': {
		\      'defaultAction': 'open',
		\    },
		\    'word': {
		\      'defaultAction': 'insert',
		\    },
		\    'command_history': {
		\      'defaultAction': 'execute',
		\    },
		\    'help': {
		\      'defaultAction': 'open',
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:true,
		\      'filterSplitDirection': 'floating',
		\      'split': 'floating',
		\      'filterFloatingPosition': 'top',
		\      'floatingBorder': 'single',
		\      'previewFloating': v:true,
		\      'previewSplit': 'vertical',
		\      'previewFloatingBorder': 'single',
		\      'previewFloatingTitle': 'Preview',
		\      'previewFloatingTitlePos': 'center',
		\      'floatingTitle': 'Result',
		\      'floatingTitlePos': 'center',
		\    },
		\    'filer': {
		\      'split': 'floating',
		\      'filterFloatingPosition': 'top',
		\      'floatingBorder': 'single',
		\      'previewFloating': v:true,
		\      'previewSplit': 'vertical',
		\      'previewFloatingBorder': 'single',
		\      'previewFloatingTitle': 'Preview',
		\      'previewFloatingTitlePos': 'center',
		\      'floatingTitle': 'Result',
		\      'floatingTitlePos': 'center',
		\    },
		\  },
		\})

call ddu#custom#patch_local('files', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'file_rec', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\      'converters': ['converter_devicon'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:true,
		\      'winCol': (&columns / 2) - &columns / 3 - 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 3,
		\      'winHeight': &lines - 12,
		\      'previewCol': &columns / 2,
		\      'previewRow': 6,
		\      'previewWidth': &columns / 3,
		\      'previewHeight': &lines - 12,
		\      'autoAction': {
		\        'name': 'preview'
		\      },
		\    },
		\  },
		\})

call ddu#custom#patch_local('history', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'file_old', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\      'converters': ['converter_devicon'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:true,
		\      'winCol': (&columns / 2) - &columns / 3 - 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 3,
		\      'winHeight': &lines - 12,
		\      'previewCol': &columns / 2,
		\      'previewRow': 6,
		\      'previewWidth': &columns / 3,
		\      'previewHeight': &lines - 12,
		\      'autoAction': {
		\        'name': 'preview'
		\      },
		\    },
		\  },
		\})

call ddu#custom#patch_local('reg', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'register', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:false,
		\    },
		\  },
		\})

call ddu#custom#patch_local('buffer', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'buffer', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\      'converters': ['converter_devicon'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:false,
		\    },
		\  },
		\})

call ddu#custom#patch_local('help', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'help', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:true,
		\      'winCol': (&columns / 2) - &columns / 3 - 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 3,
		\      'winHeight': &lines - 12,
		\      'previewCol': &columns / 2,
		\      'previewRow': &lines - 4,
		\      'previewSplit': 'horizontal',
		\      'previewWidth': &columns / 3,
		\      'previewHeight': &lines - 9,
		\    },
		\  },
		\})

call ddu#custom#patch_local('command_history', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'command_history', 'params': {}}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:false,
		\    },
		\  },
		\})

call ddu#custom#patch_local('markdown', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'markdown'}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'sourceParams': {
		\    'markdown': {
		\      'style': 'parent',
		\      'chunkSize': 5,
		\      'limit': 1000,
		\    }
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'startFilter': v:false,
		\      'winCol': (&columns / 2) - &columns / 3 - 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 3,
		\      'winHeight': &lines - 12,
		\      'previewCol': &columns / 2,
		\      'previewRow': 6,
		\      'previewWidth': &columns / 3,
		\      'previewHeight': &lines - 12,
		\      'autoAction': {
		\        'name': 'preview'
		\      },
		\    },
		\  },
		\})

call ddu#custom#patch_local('git_diff', {
		\  'ui': 'ff',
		\  'sources': [{'name': 'git_diff'}],
		\  'sourceOptions': {
		\    '_': {
		\      'matchers': ['matcher_substring'],
		\    },
		\  },
		\  'sourceParams': {
		\    'show': v:true,
		\  },
		\  'uiParams': {
		\    'ff': {
		\      'winCol': (&columns / 2) - &columns / 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 2,
		\      'winHeight': &lines - 12,
		\      'startFilter': v:false,
		\    },
		\  },
		\})

call ddu#custom#patch_local('live_rg', {
		\  'ui': 'ff',
		\  'sources': [{
    \    'name': 'rg',
    \    'options': {
    \      'matchers': [],
    \      'volatile': v:true,
    \    }
    \  }],
		\  'uiParams': {
		\    'ff': {
		\      'ignoreEmpty': v:false,
		\      'autoResize': v:false,
		\      'startFilter': v:true,
		\      'winCol': (&columns / 2) - &columns / 3 - 2,
		\      'winRow': 6,
		\      'winWidth': &columns / 3,
		\      'winHeight': &lines - 12,
		\      'previewCol': &columns / 2,
		\      'previewRow': 6,
		\      'previewWidth': &columns / 3,
		\      'previewHeight': &lines - 12,
		\      'autoAction': {
		\        'name': 'preview'
		\      },
		\    },
		\  },
		\})

nnoremap <silent> <Leader>fr :call ddu#start({ 'name': 'reg' })<CR>
nnoremap <silent> <Leader>fb :call ddu#start({ 'name': 'buffer' })<CR>
nnoremap <silent> <Leader>fh :call ddu#start({ 'name': 'help' })<CR>
nnoremap <silent> <Leader>fc :call ddu#start({ 'name': 'command_history' })<CR>
nnoremap <silent> <Leader>fm :call ddu#start({ 'name': 'markdown' })<CR>

augroup MyAutoCmd
  autocmd FileType ddu-ff call s:ddu_my_settings()
augroup END

function! s:ddu_my_settings() abort
setlocal cursorline
nnoremap <buffer> <CR>
\ <Cmd>call ddu#ui#do_action('itemAction')<CR>
nnoremap <buffer> i
\ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
nnoremap <buffer> q
\ <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer> <C-c>
\ <Cmd>call ddu#ui#do_action('quit')<CR>
nnoremap <buffer> p
\ <Cmd>call ddu#ui#do_action('preview')<CR>
nnoremap <buffer> <C-n>
\ <Cmd>call ddu#ui#multi_actions([['cursorNext'], ['preview']])<CR>
nnoremap <buffer> <C-p>
\ <Cmd>call ddu#ui#multi_actions([['cursorPrevious'], ['preview']])<CR>
endfunction

augroup MyAutoCmd
  autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
augroup END

function! s:ddu_filter_my_settings() abort
inoremap <buffer> <CR>
\ <Cmd>call ddu#ui#do_action('itemAction')<CR>
inoremap <buffer> <C-c>
\ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
inoremap <buffer> <C-n>
\ <Cmd>call ddu#ui#multi_actions([['cursorNext'], ['preview']])<CR>
inoremap <buffer> <C-p>
\ <Cmd>call ddu#ui#multi_actions([['cursorPrevious'], ['preview']])<CR>
nnoremap <buffer> <C-c>
\ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
nnoremap <buffer> <C-n>
\ <Cmd>call ddu#ui#multi_actions([['cursorNext'], ['preview']])<CR>
nnoremap <buffer> <C-p>
\ <Cmd>call ddu#ui#multi_actions([['cursorPrevious'], ['preview']])<CR>
nnoremap <buffer> p
\ <Cmd>call ddu#ui#do_action('preview')<CR>
endfunction

augroup MyAutoCmd
  autocmd FileType ddu-filer call s:ddu_filer_my_settings()
augroup END

function! s:ddu_filer_my_settings() abort
nnoremap <buffer> <CR>
\ <Cmd>call ddu#ui#do_action('itemAction')<CR>
nnoremap <buffer> <C-c>
\ <Cmd>call ddu#ui#do_action('quit')<CR><Esc>
nnoremap <buffer> p
\ <Cmd>call ddu#ui#do_action('preview')<CR>
nnoremap <buffer> h
\ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
nnoremap <buffer> l
\ <Cmd>call ddu#ui#do_action('expandItem')<CR>
endfunction
