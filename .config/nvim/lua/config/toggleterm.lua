local autocmd = vim.api.nvim_create_autocmd
require("toggleterm").setup({
  highlights = {
    Normal = {
      link = 'Normal'
    }
  }
})

local Terminal = require("toggleterm.terminal").Terminal
local tig = Terminal:new({ cmd = "tig", hidden = true, direction = "float" })

function _tig_toggle()
  if vim.env.TMUX then
    os.execute('tmux popup -w90% -h90% -E "tig"')
  else
    tig:toggle()
  end
end

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })

function _lazygit_toggle()
  if vim.env.TMUX then
    os.execute("tmux popup -d '#{pane_current_path}' -w90% -h90% -E 'lazygit'")
  else
    lazygit:toggle()
  end
end

local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })

function _lazydocker_toggle()
  if vim.env.TMUX then
    os.execute('tmux popup -w90% -h90% -E "lazydocker"')
  else
    lazydocker:toggle()
  end
end

local gocheat = Terminal:new({ cmd = "gocheat", hidden = true, direction = "float" })

function _gocheat_toggle()
  if vim.env.TMUX then
    os.execute('tmux popup -w90% -h90% -E "gocheat"')
  else
    gocheat:toggle()
  end
end

local term = Terminal:new({ hidden = true, direction = "float" })

function _term_toggle()
  if vim.env.TMUX then
    os.execute('tmux popup -w90% -h90%')
  else
    term:toggle()
  end
end

vim.keymap.set("n", "<Leader>tig", ":lua _tig_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>lg", ":lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ld", ":lua _lazydocker_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ch", ":lua _gocheat_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>to", ":lua _term_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tv", ":ToggleTerm size=80 direction=vertical<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ts", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  vim.keymap.set("t", "<C-\\>", "<C-\\><C-N>")
end

autocmd("TermOpen", {
  pattern = "*",
  command = "lua set_terminal_keymaps()",
})
