local opt = { silent = true, noremap = true }
vim.keymap.set("n", "<Leader>w", ":w<CR>", opt)
vim.keymap.set("n", "<Leader>o", ":wincmd p<CR>", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<Leader>n", ":nohl<CR>", opt)

vim.keymap.set("n", "L", "$")
vim.keymap.set("n", "H", "^")
vim.keymap.set("v", "L", "$")
vim.keymap.set("v", "H", "^")
vim.keymap.set("s", "L", "L")
vim.keymap.set("s", "H", "H")

vim.keymap.set("n", "J", "5j")
vim.keymap.set("n", "K", "5k")
vim.keymap.set("v", "J", "5j")
vim.keymap.set("v", "K", "5k")
vim.keymap.set("s", "J", "J")
vim.keymap.set("s", "K", "K")

vim.keymap.set("n", "<Leader>P", '"0P')
vim.keymap.set("n", "<Leader>p", '"0p')
vim.keymap.set("n", "<Leader>r", "ciw<C-r>0<Esc>b")

vim.keymap.set("i", "<C-c>", "<C-[>")
vim.keymap.set("i", "<C-[>", "<C-c>")

vim.keymap.set("c", "<C-f>", "<Right>")
vim.keymap.set("c", "<C-b>", "<Left>")
vim.keymap.set("c", "<C-a>", "<Home>")
vim.keymap.set("c", "<C-e>", "<End>")

vim.keymap.set("n", "<", "<<")
vim.keymap.set("n", ">", ">>")
vim.keymap.set("v", "<", "<<<Esc>gv")
vim.keymap.set("v", ">", ">><Esc>gv")

vim.keymap.set({"n", "v"}, "<C-n>", "<C-a>")
vim.keymap.set({"n", "v"}, "<C-p>", "<C-x>")
