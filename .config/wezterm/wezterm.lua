local wezterm = require("wezterm")
local mux = wezterm.mux
local utils = wezterm.utils
local keybindings = require("config.keybindings")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime '%Y-%m-%d %H:%M:%S'

  -- Make it italic and underlined
  window:set_right_status(wezterm.format {
    { Attribute = { Underline = 'Single' } },
    { Attribute = { Italic = true } },
    { Text = " " .. date .. " " },
  })
end)

-- Maximize window when starting wezterm
wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

config.font = wezterm.font("HackGen Console NFJ", { italic = false })
config.font_size = 11.0
config.background = {
  {
    source = { Color = "black" },
    width = "100%",
    height = "100%",
    opacity = 0.95
  },
  {
    source = { File = wezterm.config_dir .. "/background/background.png" },
    repeat_x = "NoRepeat",
    height = "Contain",
    width = "Contain",
    horizontal_align = "Center",
    opacity = 0.3
  },
}
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0
}

-- default domain setting
local wsl_domains = wezterm.default_wsl_domains()
config.wsl_domains = wsl_domains
config.default_domain = "WSL:Ubuntu-20.04"

-- keybindings
config.disable_default_key_bindings = true
config.keys = keybindings.keys
config.key_tables = keybindings.key_tables

-- other
config.tab_bar_at_bottom = true

-- launch_menu
config.launch_menu = {
  {
    label = "PowerShell",
    args = { "powershell.exe" },
    domain = { DomainName = "local" }
  },
  {
    label = "zsh",
    args = { "zsh", "-l" }
  },
}

return config
