require('toggleterm').setup()

local Terminal = require('toggleterm.terminal').Terminal
local tig = Terminal:new({ cmd = "tig", hidden = true, direction = "float"})

function _tig_toggle()
  tig:toggle()
end

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float"})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.keymap.set("n", "<Leader>tig", ":lua _tig_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>lg", ":lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
