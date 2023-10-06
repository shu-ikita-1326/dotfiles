require("gitsigns").setup({
  numhl = true,
  linehl = false,
  word_diff = false,
})

local opt = { silent = true, noremap = true }

vim.keymap.set("n", "[c", "<Cmd>Gitsigns prev_hunk<CR>", opt)
vim.keymap.set("n", "]c", "<Cmd>Gitsigns next_hunk<CR>", opt)
vim.keymap.set("n", "<Leader>gb", "<Cmd>Gitsigns blame_line<CR>", opt)
vim.keymap.set("n", "<Leader>tb", "<Cmd>Gitsigns toggle_current_line_blame<CR>", opt)
vim.keymap.set("n", "<Leader>td", "<Cmd>Gitsigns toggle_deleted<CR>", opt)
vim.keymap.set("n", "<Leader>gd", "<Cmd>Gitsigns diffthis<CR>", opt)
