require('gitsigns').setup()

vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>")
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>")
vim.keymap.set("n", "<Leader>gb", ":Gitsigns blame_line<CR>")
vim.keymap.set("n", "<Leader>tb", ":Gitsigns toggle_current_line_blame<CR>")
vim.keymap.set("n", "<Leader>td", ":Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<Leader>gd", ":Gitsigns diffthis<CR>")
