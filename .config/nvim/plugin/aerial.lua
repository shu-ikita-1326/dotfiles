require('aerial').setup()
local opt = { silent=true, noremap=true}

vim.keymap.set("n", "<Leader>a", ":AerialToggle float<CR>", opt)
