local options = {
  encoding = "utf-8",
  fileencoding = "utf-8",
  title = true,
  backup = false,
  wrap = false,
  signcolumn = "yes",
  undofile = true,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  incsearch = true,
  hlsearch = true,
  swapfile = false,
  ambiwidth = "single",
  number = true,

  tabstop = 2,
  shiftwidth = 2,
  softtabstop = 2,
  expandtab = true,

  scrolloff = 5,

  laststatus = 3,
  termguicolors = true,

  listchars = "tab:»-,trail:･,eol:↲,nbsp:%",
  list = true,
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
