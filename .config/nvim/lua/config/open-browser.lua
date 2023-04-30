local opt = { silent = true, noremap = true }
vim.keymap.set("v", "<Leader>se", ":<C-U>call openbrowser#_keymap_search('v')<CR>", opt)
vim.keymap.set("n", "<Leader>se", "viw:<C-U>call openbrowser#_keymap_search('n')<CR>", opt)
