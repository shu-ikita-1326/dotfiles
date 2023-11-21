local M = {}

local function wide_layout(columns, lines)
  return {
    winCol = math.floor((columns - (columns * 0.9)) / 2),
    winWidth = math.floor(columns * 0.9),
    winRow = 5,
    winHeight = lines - 8,
    previewCol = math.floor(columns / 2),
    previewWidth = math.floor((columns * 0.9) / 2 - 2),
    previewRow = 6,
    previewHeight = lines - 10,
  }
end

local function narrow_layout(columns, lines)
  return {
    winCol = math.floor((columns - (columns * 0.9)) / 2),
    winWidth = math.floor(columns * 0.9),
    winRow = 5,
    winHeight = math.floor(lines * 0.4),
    previewCol = math.floor((columns - (columns * 0.9)) / 2),
    previewWidth = math.floor(columns * 0.9),
    previewRow = math.floor(lines * 0.4) + 5 + 2,
    previewHeight = lines - (math.floor(lines * 0.4) + 5 + 2) - 3,
  }
end

M.on_cursor = function(width, f_title)
  return {
    autoResize = true,
    winRow = vim.fn.screenrow() - 1,
    winCol = vim.fn.screencol(),
    winWidth = width + 3,
    floatingTitle = f_title,
    floatingTitlePos = "left",
    ignoreEmpty = true,
  }
end

M.setting = function()
  local columns = vim.api.nvim_get_option("columns")
  local lines = vim.api.nvim_get_option("lines")

  if columns < 200 then
    vim.fn["ddu#custom#patch_global"]("uiParams", {
      _ = narrow_layout(columns, lines),
    })
  else
    vim.fn["ddu#custom#patch_global"]("uiParams", {
      _ = wide_layout(columns, lines),
    })
  end
end

return M
