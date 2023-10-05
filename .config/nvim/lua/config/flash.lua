local opt = { silent = true, noremap = true }
local flash = require("flash")
flash.setup({
  modes = {
    search = {
      enabled = false,
    }
  }
})

vim.keymap.set("n", "ss", "<Cmd>lua require('flash').jump()<CR>", opt)
vim.keymap.set("n", "st", "<Cmd>lua require('flash').treesitter()<CR>", opt)
