require("aerial").setup({
  layout = {
    default_direction = "prefer_left",
  },
})
local opt = { silent = true, noremap = true }

vim.keymap.set("n", "<Leader>a", ":AerialToggle<CR>", opt)
