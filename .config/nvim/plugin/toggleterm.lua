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

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float"})

function _lazydocker_toggle()
  lazydocker:toggle()
end
vim.keymap.set("n", "<Leader>tig", ":lua _tig_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>lg", ":lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
vim.keymap.set("n", "<Leader>ld", ":lua _lazydocker_toggle()<CR>", {noremap = true, silent = true})
