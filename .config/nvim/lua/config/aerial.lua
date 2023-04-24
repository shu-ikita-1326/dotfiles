require("aerial").setup({
  layout = {
    default_direction = "prefer_left",
  },
  manage_folds = true,
})
local opt = { silent = true, noremap = true }

vim.keymap.set("n", "<Leader>a", ":AerialToggle<CR>", opt)
