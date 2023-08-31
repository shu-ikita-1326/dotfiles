local opt = { silent = true, noremap = true }
vim.keymap.set("v", "<Leader>se", "<Plug>(openbrowser-search)<CR>", opt)
vim.keymap.set("n", "<Leader>se", "<Plug>(openbrowser-smart-search)<CR>", opt)
vim.keymap.set({"n", "v"}, "<Leader>bo", "<Plug>(openbrowser-open)<CR>", opt)
