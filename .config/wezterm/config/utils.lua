local wezterm = require("wezterm")
local M = {}

function M.set_move_pane_key(key, direction, timeout_msec)
  return {
    key = key,
    action = wezterm.action.Multiple {
      wezterm.action.ActivatePaneDirection(direction),
      wezterm.action.ActivateKeyTable {
        name = "move_pane",
        one_shot = false,
        timeout_milliseconds = timeout_msec,
      },
    }
  }
end

function M.set_resize_pane_key(key, direction, timeout_msec, num)
  return {
    key = key,
    action = wezterm.action.Multiple {
      wezterm.action.AdjustPaneSize({ direction, num }),
      wezterm.action.ActivateKeyTable {
        name = "resize_pane",
        one_shot = false,
        timeout_milliseconds = timeout_msec,
      },
    }
  }
end

return M
