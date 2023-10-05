vim.env.BASE_DIR = vim.fn.expand("~/.config/nvim")
vim.env.CONF_DIR = vim.fn.expand("~/.config")

vim.env.CHEATDIR = vim.fn.expand("~/cheat")
vim.env.NOTEDIR = vim.fn.expand("~/note")
vim.env.LABDIR = vim.fn.expand("~/lab")
vim.env.MINUTESDIR = vim.fn.expand("~/minutes")

if vim.fn.isdirectory(vim.env.CHEATDIR) then
  vim.fn.mkdir(vim.env.CHEATDIR, "p")
end

if vim.fn.isdirectory(vim.env.NOTEDIR) then
  vim.fn.mkdir(vim.env.NOTEDIR, "p")
end

if vim.fn.isdirectory(vim.env.LABDIR) then
  vim.fn.mkdir(vim.env.LABDIR, "p")
end

if vim.fn.isdirectory(vim.env.MINUTESDIR) then
  vim.fn.mkdir(vim.env.MINUTESDIR, "p")
end

require("keymap")
require("option")
require("plugin")
require("autocmd")
