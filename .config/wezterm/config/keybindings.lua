local wezterm = require("wezterm")
local mux = wezterm.mux
local M = {}

-- keybindings
M.keys = {
  {
    key = "T",
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
    key = "P",
    mods = "CTRL",
    action = wezterm.action.ActivateCommandPalette,
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
      key = "T",
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
    { key = "h", action = wezterm.action.ActivatePaneDirection "Left", },
    { key = "l", action = wezterm.action.ActivatePaneDirection "Right" },
    { key = "k", action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "j", action = wezterm.action.ActivatePaneDirection "Down", },
    { key = "H", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { key = "L", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { key = "K", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    { key = "J", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
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
      key = 'o',
      action = wezterm.action.QuickSelectArgs {
        label = 'open url',
        patterns = {
          'https?://\\S+',
        },
        action = wezterm.action_callback(function(window, pane)
          local url = window:get_selection_text_for_pane(pane)
          wezterm.log_info('opening: ' .. url)
          wezterm.open_with(url)
        end),
      },
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
