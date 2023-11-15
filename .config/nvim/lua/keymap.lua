vim.g.mapleader = " "

local opt = { silent = true, noremap = true }

vim.keymap.set("n", "<Leader>w", "<Cmd>w<CR>", opt)

vim.keymap.set("n", "<Leader>nn", "<Cmd>nohlsearch<CR>", opt)

vim.keymap.set("n", "<Leader>o", "<Cmd>wincmd p<CR>", opt)
vim.keymap.set("n", "<C-h>", "<C-w>h", opt)
vim.keymap.set("n", "<C-l>", "<C-w>l", opt)

vim.keymap.set({ "n", "v" }, "J", "5j", opt)
vim.keymap.set({ "n", "v" }, "K", "5k", opt)

vim.keymap.set({ "n", "v" }, "L", "$", opt)
vim.keymap.set({ "n", "v" }, "H", "^", opt)

vim.keymap.set("n", "<Leader>p", '"0p', opt)
vim.keymap.set("n", "<Leader>P", '"0P', opt)
vim.keymap.set("n", "<Leader>r", "ciw<C-r>0<Esc>b", opt)

vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>")
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>")
vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>")
vim.keymap.set({ "i", "c" }, "<C-e>", "<End>")
vim.keymap.set({ "i", "c" }, "<C-d>", "<Delete>")

vim.keymap.set("n", ">", ">>", opt)
vim.keymap.set("n", "<", "<<", opt)
vim.keymap.set("v", ">", ">><Esc>gv", opt)
vim.keymap.set("v", "<", "<<<Esc>gv", opt)
