function! s:snippet_loader(globStr)
  let paths = glob(a:globStr)
  if paths == ""
    echo "Snippet file is not found."
  endif
  for p in split(paths, "\n")
    let lang = fnamemodify(p, ":h:t")
    if lang ==# "global"
      let lang = '*'
    endif
    call denippet#load(p, lang)
  endfor
endfunction

call s:snippet_loader($CONF_DIR . "/denippet/**/*.*")
