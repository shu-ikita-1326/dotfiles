local wezterm = require("wezterm")
local utils = require("config.utils")
local mux = wezterm.mux
local M = {}
local bg = require("background")

-- keybindings
M.keys = {
  {
    key = "J",
    mods = "CTRL",
    action = wezterm.action.Multiple {
      wezterm.action.EmitEvent "activate-wez-mux-key",
      wezterm.action.ActivateKeyTable {
        name = "use_wez_mux",
        one_shot = false,
      },
    }
  },
  {
    key = "L",
    mods = "CTRL",
    action = wezterm.action.ActivateKeyTable {
      name = "launch_control",
    }
  },
  {
    key = "V",
    mods = "CTRL",
    action = wezterm.action.PasteFrom "Clipboard",
  },
  {
    key = "F11",
    mods = "",
    action = wezterm.action.ToggleFullScreen,
  },
  {
    key = "l",
    mods = "ALT",
    action = wezterm.action.ShowDebugOverlay,
  },
  {
    key = "p",
    mods = "ALT",
    action = wezterm.action.ActivateCommandPalette,
  },
  {
    key = "F",
    mods = "CTRL",
    action = wezterm.action.QuickSelect,
  },
  {
    key = "P",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(-1),
  },
  {
    key = "N",
    mods = "CTRL",
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'O',
    mods = "CTRL",
    action = wezterm.action.QuickSelectArgs {
      label = 'open url',
      patterns = {
        '\\b\\w+://\\S+[)/a-zA-Z0-9-]+',
      },
      action = wezterm.action_callback(function(window, pane)
        local url = window:get_selection_text_for_pane(pane)
        wezterm.log_info('opening: ' .. url)
        wezterm.open_with(url)
      end),
    },
  },
  {
    key = ";",
    mods = "CTRL",
    action = wezterm.action.IncreaseFontSize,
  },
  {
    key = "-",
    mods = "CTRL",
    action = wezterm.action.DecreaseFontSize,
  },
  {
    key = "B",
    mods = "CTRL",
    action = wezterm.action.InputSelector {
      action = wezterm.action_callback(function(window, pane, id, label)
        if not id and not label then
          wezterm.log_info("cancelled")
        else
          for k, v in pairs(bg.settings) do
            if label == k then
              local overrides = window:get_config_overrides() or {}
              overrides.background = v
              wezterm.log_info("changed background.")
              window:set_config_overrides(overrides)
            end
          end
        end
      end),
      title = "Choice background.",
      choices = bg.list
    }
  },
  {
    key = "R",
    mods = "CTRL",
    action = wezterm.action.ReloadConfiguration
  },
}

M.key_tables = {
  use_wez_mux = {
    {
      key = "j",
      mods = "CTRL",
      action = wezterm.action.ActivateKeyTable {
        name = "tmux_keybind",
      },
    },
    {
      key = "J",
      mods = "CTRL",
      action = wezterm.action.Multiple {
        wezterm.action.EmitEvent "deactivate-wez-mux-key",
        wezterm.action.PopKeyTable
      }
    },
  },
  tmux_keybind = {
    { key = "x", action = wezterm.action.CloseCurrentPane { confirm = true } },
    { key = "X", action = wezterm.action.CloseCurrentTab { confirm = true } },
    { key = "c", action = wezterm.action.SpawnTab "CurrentPaneDomain" },
    {
      key = "C",
      action = wezterm.action_callback(function()
        local tab, pane, window = mux.spawn_window({})
        window:gui_window():maximize()
      end),
    },
    { key = "v", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "s", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    utils.set_move_pane_key("h", "Left", 500),
    utils.set_move_pane_key("l", "Right", 500),
    utils.set_move_pane_key("k", "Up", 500),
    utils.set_move_pane_key("j", "Down", 500),
    utils.set_resize_pane_key("H", "Left", 500, 5),
    utils.set_resize_pane_key("L", "Right", 500, 5),
    utils.set_resize_pane_key("K", "Up", 500, 3),
    utils.set_resize_pane_key("J", "Down", 500, 3),
    { key = "n", action = wezterm.action.ActivateTabRelative(-1) },
    { key = "p", action = wezterm.action.ActivateTabRelative(1) },
    { key = "z", action = wezterm.action.TogglePaneZoomState },
    { key = "[", action = wezterm.action.ActivateCopyMode },
    { key = "d", action = wezterm.action.DetachDomain "CurrentPaneDomain" },
    { key = "P", action = wezterm.action.ActivateWindowRelative(-1) },
    { key = "N", action = wezterm.action.ActivateWindowRelative(1) },
    {
      key = "r",
      action = wezterm.action.ActivateKeyTable {
        name = "resize_pane",
        one_shot = false,
        timeout_milliseconds = 500
      }
    },
    {
      key = "m",
      action = wezterm.action.ActivateKeyTable {
        name = "move_pane",
        one_shot = false,
        timeout_milliseconds = 500
      }
    },
    {
      key = ",",
      action = wezterm.action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(function(window, pane, line)
          if line then
            window:active_tab():set_title(line)
          end
        end),
      },
    },
  },
  resize_pane = {
    { key = "H", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "L", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { key = "K", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    { key = "J", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
  },
  move_pane = {
    { key = "h", action = wezterm.action.ActivatePaneDirection "Left", },
    { key = "l", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", action = wezterm.action.ActivatePaneDirection "Down", },
  },
  launch_control = {
    { key = "t", action = wezterm.action.ShowLauncherArgs { flags = "TABS" }, },
    { key = "d", action = wezterm.action.ShowLauncherArgs { flags = "DOMAINS" }, },
    { key = "i", action = wezterm.action.ShowLauncherArgs { flags = "LAUNCH_MENU_ITEMS" }, },
    { key = "w", action = wezterm.action.ShowLauncherArgs { flags = "WORKSPACES" }, },
    { key = "c", action = wezterm.action.ShowLauncherArgs { flags = "COMMANDS" }, },
    { key = "k", action = wezterm.action.ShowLauncherArgs { flags = "KEY_ASSIGNMENTS" }, },
    { key = "l", action = wezterm.action.ShowLauncher },
  }
}

return M
