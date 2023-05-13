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

-- tmux like
vim.keymap.set({ "t", "n" }, "<C-j>j", "<Cmd>wincmd j<CR>", { silent = true })
vim.keymap.set({ "t", "n" }, "<C-j>k", "<Cmd>wincmd k<CR>", { silent = true })
vim.keymap.set({ "t", "n" }, "<C-j>l", "<Cmd>wincmd l<CR>", { silent = true })
vim.keymap.set({ "t", "n" }, "<C-j>h", "<Cmd>wincmd h<CR>", { silent = true })
vim.keymap.set({ "t", "n" }, "<C-j>v", "<Cmd>vsplit<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>s", "<Cmd>split<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>t", "<Cmd>terminal<CR>", opts)
vim.keymap.set("t", "<C-\\>", "<C-\\><C-n>", opts)

vim.keymap.set({ "t", "n" }, "<C-j>n", "<Cmd>tabnext<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>p", "<Cmd>tabprevious<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>c", "<Cmd>tabnew<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>x", "<Cmd>close<CR>", opts)
vim.keymap.set({ "t", "n" }, "<C-j>X", "<Cmd>tabclose<CR>", opts)
