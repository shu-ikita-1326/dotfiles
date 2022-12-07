require('toggleterm').setup()

local Terminal = require('toggleterm.terminal').Terminal
local tig = Terminal:new({ cmd = "tig", hidden = true, direction = "float"})

function _tig_toggle()
  tig:toggle()
end

vim.keymap.set("n", "<Leader>tig", ":lua _tig_toggle()<CR>", {noremap = true, silent = true})
