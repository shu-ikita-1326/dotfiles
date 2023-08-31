require("gitsigns").setup({
  numhl = true,
  linehl = false,
  word_diff = false,
})

local opt = { silent = true, noremap = true }

vim.keymap.set("n", "[c", ":Gitsigns prev_hunk<CR>", opt)
vim.keymap.set("n", "]c", ":Gitsigns next_hunk<CR>", opt)
vim.keymap.set("n", "<Leader>gb", ":Gitsigns blame_line<CR>", opt)
vim.keymap.set("n", "<Leader>tb", ":Gitsigns toggle_current_line_blame<CR>", opt)
vim.keymap.set("n", "<Leader>td", ":Gitsigns toggle_deleted<CR>", opt)
vim.keymap.set("n", "<Leader>gd", ":Gitsigns diffthis<CR>", opt)
