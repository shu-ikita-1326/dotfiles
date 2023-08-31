local autocmd = vim.api.nvim_create_autocmd
require("toggleterm").setup({
  highlights = {
    Normal = {
      link = 'Normal'
    }
  },
  auto_scroll = false,
  start_in_insert = false,
  open_mapping = [[<C-\><C-\>]]
})

local Terminal = require("toggleterm.terminal").Terminal

if vim.fn.executable("lazygit") == 1 then
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
  function _lazygit_toggle()
    if vim.env.TMUX then
      local git_root = vim.fn.system("git rev-parse --show-toplevel")
      git_root = string.gsub(git_root, "\n", "")
      os.execute("tmux popup -d '" .. git_root:sub(1, -1) .. "' -w90% -h90% -E 'lazygit'")
    else
      lazygit:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>lg", ":lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
end

if vim.fn.executable("lazydocker") == 1 then
  local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
  function _lazydocker_toggle()
    if vim.env.TMUX then
      os.execute('tmux popup -w90% -h90% -E "lazydocker"')
    else
      lazydocker:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>ld", ":lua _lazydocker_toggle()<CR>", { noremap = true, silent = true })
end

local term = Terminal:new({ hidden = true, direction = "float" })

function _term_toggle()
  if vim.env.TMUX then
    os.execute('tmux popup -w90% -h90%')
  else
    term:toggle()
  end
end

vim.keymap.set("n", "<Leader>to", ":lua _term_toggle()<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tt", ":ToggleTermToggleAll<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t1", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t2", ":2ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t3", ":3ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tv", ":ToggleTerm size=80 direction=vertical<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ts", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('n', '<C-j>h', "i<Cmd>wincmd h<CR>", opts)
  vim.keymap.set('n', '<C-j>j', "i<Cmd>wincmd j<CR>", opts)
  vim.keymap.set('n', '<C-j>k', "i<Cmd>wincmd k<CR>", opts)
  vim.keymap.set('n', '<C-j>l', "i<Cmd>wincmd l<CR>", opts)
end

autocmd("TermOpen", {
  pattern = "term://*",
  command = "lua set_terminal_keymaps()",
})
