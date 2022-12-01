vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>")
vim.keymap.set("n", "<Leader>gf", ":Telescope git_files<CR>")
vim.keymap.set("n", "<Leader>gs", ":Telescope git_status<CR>")
vim.keymap.set("n", "<Leader>gr", ":Telescope live_grep<CR>")
vim.keymap.set("n", "<Leader>fe", ":Telescope file_browser<CR>")
vim.keymap.set("n", "<Leader>h", ":Telescope frecency<CR>")

require("telescope").load_extension "file_browser"
require("telescope").load_extension "frecency"
