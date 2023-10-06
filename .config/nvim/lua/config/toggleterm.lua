local autocmd = vim.api.nvim_create_autocmd

local shell = vim.o.shell
if vim.fn.has("win32") == 1 and vim.fn.exists("g:neovide") == 1 then
  shell = "powershell"
end

require("toggleterm").setup({
  highlights = {
    Normal = {
      link = "Normal",
    },
  },
  float_opts = {
    border = "rounded",
  },
  auto_scroll = false,
  start_in_insert = true,
  open_mapping = [[<C-\><C-\>]],
  shell = shell,
})

local Terminal = require("toggleterm.terminal").Terminal

if vim.fn.executable("lazygit") == 1 then
  local function _lazygit_toggle()
    local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
    local panes = vim.fn.system("tmux list-panes")
    local rows = select(2, panes:gsub("\n", "\n"))
    if vim.env.TMUX and rows >= 2 then
      local git_root = vim.fn.system("git rev-parse --show-toplevel")
      git_root = string.gsub(git_root, "\n", "")
      os.execute("tmux popup -d '" .. git_root:sub(1, -1) .. "' -w90% -h90% -E 'lazygit'")
    else
      lazygit:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>lg", _lazygit_toggle, { noremap = true, silent = true })
end

if vim.fn.executable("lazydocker") == 1 then
  local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float" })
  local function _lazydocker_toggle()
    local panes = vim.fn.system("tmux list-panes")
    local rows = select(2, panes:gsub("\n", "\n"))
    if vim.env.TMUX and rows >= 2 then
      os.execute('tmux popup -w90% -h90% -E "lazydocker"')
    else
      lazydocker:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>ld", _lazydocker_toggle, { noremap = true, silent = true })
end

local function _term_toggle()
  local term = Terminal:new({ hidden = true, direction = "float" })
  local panes = vim.fn.system("tmux list-panes")
  local rows = select(2, panes:gsub("\n", "\n"))
  if vim.env.TMUX and rows >= 2 then
    os.execute("tmux popup -w90% -h90%")
  else
    term:toggle()
  end
end

vim.keymap.set("n", "<Leader>to", _term_toggle, { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tt", "<Cmd>ToggleTermToggleAll<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t1", "<Cmd>1ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t2", "<Cmd>2ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>t3", "<Cmd>3ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tv", "<Cmd>ToggleTerm size=80 direction=vertical<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ts", "<Cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.opt.number = false
  vim.keymap.set("n", "<C-j>h", "i<Cmd>wincmd h<CR>", opts)
  vim.keymap.set("n", "<C-j>j", "i<Cmd>wincmd j<CR>", opts)
  vim.keymap.set("n", "<C-j>k", "i<Cmd>wincmd k<CR>", opts)
  vim.keymap.set("n", "<C-j>l", "i<Cmd>wincmd l<CR>", opts)
end

autocmd("TermOpen", {
  pattern = "term://*",
  command = "lua set_terminal_keymaps()",
})
