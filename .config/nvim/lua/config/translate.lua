require("translate").setup({})
local opt = { silent = true, noremap = true }
vim.keymap.set("v", "<Leader>tr", ":Translate ja<CR>", opt)
vim.keymap.set("n", "<Leader>tr", "V:Translate ja<CR>", opt)
vim.keymap.set("n", "<Leader>tw", "viw:Translate ja<CR>", opt)
