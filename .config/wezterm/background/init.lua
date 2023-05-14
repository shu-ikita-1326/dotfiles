local wezterm = require("wezterm")
local utils = require("config.utils")
local M = {}
local settings = {}

-- Create a settings.lua file with default background if settings.lua does not exist
if utils.file_exists(wezterm.config_dir .. "/background/settings.lua") == false then
  local fpath = wezterm.config_dir .. "/background/settings.lua"
  io.output(fpath)
  local f = io.open(fpath, "w")
  f:write([[local wezterm = require("wezterm")
  return {
  default = {
    {
      source = { Color = "black" },
      width = "100%",
      height = "100%",
      opacity = 0.95
    },
  },
  neovim = {
    {
      source = { Color = "black" },
      width = "100%",
      height = "100%",
      opacity = 0.95
    },
    {
      source = { File = wezterm.config_dir .. "/background/img/background.png" },
      repeat_x = "NoRepeat",
      height = "Contain",
      width = "Contain",
      horizontal_align = "Center",
      opacity = 0.3
    },
  },
}]])
else
  settings = require("background.settings")
end


M.settings = settings

M.list = {}

for k, v in pairs(M.settings) do
  table.insert(M.list, { label = k })
end

return M
