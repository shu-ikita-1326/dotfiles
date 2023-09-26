let $CHEATDIR=expand('~/cheat')
let $NOTEDIR=expand('~/note')
let $LABDIR=expand('~/lab')
let $MINUTESDIR=expand('~/minutes')

if !isdirectory($CHEATDIR)
  call mkdir($CHEATDIR, 'p')
endif

if !isdirectory($NOTEDIR)
  call mkdir($NOTEDIR, 'p')
endif

if !isdirectory($LABDIR)
  call mkdir($LABDIR, 'p')
endif

if !isdirectory($MINUTESDIR)
  call mkdir($MINUTESDIR, 'p')
endif
