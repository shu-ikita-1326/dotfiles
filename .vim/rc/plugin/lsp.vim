function! s:on_lsp_buffer_enabled() abort
  setlocal signcolumn=yes
"  nmap <buffer> gd <plug>(lsp-definition)
"  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> gn <plug>(lsp-rename)
  nmap <buffer> [e <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]e <plug>(lsp-next-diagnostic)
  nmap <buffer> gh <plug>(lsp-hover)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
