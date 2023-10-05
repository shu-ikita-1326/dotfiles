local start = require("config.ddu.start")
local M = {}

M.main = function()
  local opt = { silent = true, noremap = true }
  vim.keymap.set("n", "<Leader>hh", start.old_files, opt)
  vim.keymap.set("n", "<Leader>ff", start.find_files, opt)
  vim.keymap.set("n", "<Leader>hp", start.old_repos, opt)
  vim.keymap.set("n", "<Leader>fr", start.register, opt)
  vim.keymap.set("n", "<Leader>/", start.live_grep, opt)
  vim.keymap.set("n", "<Leader>*", start.grep_string, opt)
  vim.keymap.set("n", "<Leader>?", start.grep_pattern, opt)
  vim.keymap.set("n", "<Leader>fb", start.buffer, opt)
  vim.keymap.set("n", "<Leader>fh", start.help, opt)
  vim.keymap.set("n", "<Leader>co", start.colorscheme, opt)
  vim.keymap.set("n", "<Leader>fm", start.markdown, opt)
  vim.keymap.set("n", "<Leader>fn", start.nvim_notify, opt)
  vim.keymap.set("n", "<Leader>fs", start.ddu_source, opt)
  vim.keymap.set("n", "<Leader>gs", start.git_status, opt)
  vim.keymap.set("n", "<Leader>gd", start.git_diff, opt)
  vim.keymap.set("n", "<Leader>gb", start.git_branch, opt)
  vim.keymap.set("n", "<Leader>gl", start.git_log, opt)
  vim.keymap.set("n", "<Leader>gh", start.ghq, opt)
  vim.keymap.set("n", "<Leader>fd", start.lazy_nvim, opt)
  vim.keymap.set("n", "<Leader>fl", start.line, opt)
  vim.keymap.set("n", "<Leader>ftt", start.tab, opt)
  vim.keymap.set("n", "<Leader>fta", start.go_task, opt)
  vim.keymap.set("n", "gd", start.lsp_def, opt)
  vim.keymap.set("n", "gs", start.lsp_ref, opt)
  vim.keymap.set("n", "ge", start.lsp_diagnostic, opt)
  vim.keymap.set("n", "<Leader>ca", start.lsp_codeAction, opt)
  vim.keymap.set("n", "ds", start.lsp_documentSymbol, opt)
  vim.keymap.set("n", "<Leader>le", start.line_diagnostics, opt)
  vim.keymap.set("n", "<Leader>ga", start.gitsigns_actions, opt)
  vim.keymap.set("v", "<Leader>cr", start.chatgpt_run, opt)
  vim.keymap.set("n", "<Leader>ssh", start.ssh, opt)
  vim.keymap.set("n", "<Leader>ch", start.cheat, opt)
  vim.keymap.set("n", "<Leader>note", start.note, opt)
  vim.keymap.set("n", "<Leader>min", start.minutes, opt)
end

local function util_ddu_key_mapper(params)
  local opt = { buffer = true }
  local winid = vim.api.nvim_get_current_win()
  vim.wo[winid][0].cursorline = true
  if params[4] == nil then
    vim.keymap.set(params[1], params[2], function()
      vim.fn["ddu#ui#do_action"](params[3])
    end, opt)
  else
    vim.keymap.set(params[1], params[2], function()
      vim.fn["ddu#ui#do_action"](params[3], params[4])
    end, opt)
  end
end

M.ff = function()
  local maps = {
    { "n", "<CR>", "itemAction" },
    { "n", "i", "openFilterWindow" },
    { "n", "q", "quit" },
    { "n", "<C-c>", "quit" },
    { "n", "a", "chooseAction" },
    { "n", "d", "itemAction", { name = "delete" } },
    { "n", "p", "togglePreview" },
    { "n", "<C-t>", "toggleAutoAction" },
    { "n", "<Tab>", "toggleSelectItem" },
    { "n", "A", "toggleAllItems" },
  }
  for _, v in ipairs(maps) do
    util_ddu_key_mapper(v)
  end
end

M.ff_filter = function()
  local opt = { buffer = true }
  vim.keymap.set({ "n", "i" }, "<CR>", function()
    vim.fn["ddu#ui#do_action"]("closeFilterWindow")
    vim.cmd([[:stopinsert]])
  end, opt)
  vim.keymap.set({ "n", "i" }, "<C-c>", function()
    vim.fn["ddu#ui#do_action"]("quit")
    vim.cmd([[:stopinsert]])
  end, opt)
end

return M
