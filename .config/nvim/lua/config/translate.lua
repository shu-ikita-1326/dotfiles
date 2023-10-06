require("translate").setup({
  preset = {
    output = {
      floating = {
        zindex = 300,
      },
    },
  },
})
local opt = { silent = true, noremap = true }
vim.keymap.set("v", "<Leader>tl", "<Cmd>Translate ja<CR>", opt)
vim.keymap.set("v", "<Leader>tle", "<Cmd>Translate en -output=replace<CR>", opt)
vim.keymap.set("v", "<Leader>tlj", "<Cmd>Translate ja -output=replace<CR>", opt)
vim.keymap.set("n", "<Leader>tl", "V<Cmd>Translate ja<CR><Esc>", opt)
vim.keymap.set("n", "<Leader>tw", "viw<Cmd>Translate ja<CR><Esc>", opt)
