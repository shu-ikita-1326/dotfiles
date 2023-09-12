function! rc#util#get_text_max_len(list) abort
    let s:result = 0
    if type(a:list) != v:t_list
      return 0
    endif
    for s:text in a:list
      let s:result = max([s:result, len(s:text)])
    endfor
    return s:result
endfunction

function! rc#util#get_key_max_len(dict) abort
    let s:result = 0
    if type(a:dict) != v:t_dict
      return 0
    endif
    for s:key in keys(a:dict)
      let s:result = max([s:result, len(s:text)])
    endfor
    return s:result
endfunction
