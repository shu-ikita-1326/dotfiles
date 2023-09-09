let g:lsp_diagnostics_virtual_text_align = "after"
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_highlights_enabled = 1

" Mappings
nnoremap <silent> gd <plug>(lsp-definition)
nnoremap <silent> gh <plug>(lsp-hover)
nnoremap <silent> gn <plug>(lsp-rename)
nnoremap <silent> [e <plug>(lsp-previous-diagnostic)
nnoremap <silent> ]e <plug>(lsp-next-diagnostic)
nnoremap <silent> ga :LspCodeAction<CR>
nnoremap <silent> gp :LspPeekDefinition<CR>
