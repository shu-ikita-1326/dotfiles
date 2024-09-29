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

if vim.fn.executable("btm") == 1 then
  local btm = Terminal:new({ cmd = "btm", hidden = true, direction = "float" })
  local function _btm_toggle()
    local panes = vim.fn.system("tmux list-panes")
    local rows = select(2, panes:gsub("\n", "\n"))
    if vim.env.TMUX and rows >= 2 then
      os.execute('tmux popup -w90% -h90% -E "btm"')
    else
      btm:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>btm", _btm_toggle, { noremap = true, silent = true })
end

if vim.fn.executable("slumber") == 1 then
  local btm = Terminal:new({ cmd = "slumber --file ./__dev/slumber.yml", hidden = true, direction = "float" })
  local function _btm_toggle()
    local panes = vim.fn.system("tmux list-panes")
    local rows = select(2, panes:gsub("\n", "\n"))
    if vim.env.TMUX and rows >= 2 then
      os.execute('tmux popup -w90% -h90% -E "btm"')
    else
      btm:toggle()
    end
  end

  vim.keymap.set("n", "<Leader>R", _btm_toggle, { noremap = true, silent = true })
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
vim.keymap.set("n", "<Leader>tv", "<Cmd>ToggleTerm size=80 direction=vertical<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>ts", "<Cmd>ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tf", "<Cmd>ToggleTerm direction=float<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<Leader>tt", "<Cmd>ToggleTerm direction=tab<CR>", { noremap = true, silent = true })

for i = 1, 9 do
  vim.keymap.set("n", "<Leader>t" .. i, "<Cmd>" .. i .. "ToggleTerm<CR>", { noremap = true, silent = true })
end
