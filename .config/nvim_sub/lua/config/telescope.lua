local telescope = require("telescope")
telescope.load_extension("file_browser")
telescope.load_extension("ghq")
telescope.load_extension("lazy")
local opt = { silent = true, noremap = true }
telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["<C-c>"] = require("telescope.actions").close,
      },
    },
  },
})
vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", opt)
vim.keymap.set("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
vim.keymap.set("n", "<Leader>*", ":Telescope grep_string<CR>", opt)
vim.keymap.set("n", "<Leader>:", ":Telescope command_history<CR>", opt)
vim.keymap.set("n", "<Leader>f/", ":Telescope search_history<CR>", opt)
vim.keymap.set("n", "<Leader>fn", ":Telescope notify<CR>", opt)
vim.keymap.set("n", "<Leader>gf", ":Telescope git_files<CR>", opt)
vim.keymap.set("n", "<Leader>gh", ":Telescope ghq list<CR>", opt)
vim.keymap.set("n", "<Leader>fl", ":Telescope lazy<CR>", opt)
vim.keymap.set("n", "<Leader>gs", ":Telescope git_status<CR>", opt)
vim.keymap.set("n", "<Leader>/", ":Telescope live_grep<CR>", opt)
vim.keymap.set("n", "<Leader>fr", ":Telescope registers<CR>", opt)
vim.keymap.set("n", "<Leader>fe", ":Telescope file_browser hidden=true initial_mode=normal<CR>", opt)
vim.keymap.set("n", "<Leader>h", ":Telescope oldfiles<CR>", opt)
