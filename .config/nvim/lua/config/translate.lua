require("translate").setup({
  preset = {
    output = {
      floating = {
        zindex = 300
      }
    }
  }
})
local opt = { silent = true, noremap = true }
vim.keymap.set("v", "<Leader>tl", ":Translate ja<CR>", opt)
vim.keymap.set("v", "<Leader>tle", ":Translate en -output=replace<CR>", opt)
vim.keymap.set("v", "<Leader>tlj", ":Translate ja -output=replace<CR>", opt)
vim.keymap.set("n", "<Leader>tl", "V:Translate ja<CR>", opt)
vim.keymap.set("n", "<Leader>tw", "viw:Translate ja<CR>", opt)
