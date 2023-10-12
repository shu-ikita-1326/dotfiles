local param = require("config.ddu.param")
local M = {}

M.lsp_def = function()
  vim.fn["ddu#start"](param.lsp_def)
end

M.lsp_ref = function()
  vim.fn["ddu#start"](param.lsp_ref)
end

M.line_diagnostics = function()
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(0)
  local texts = {}
  local width = 1
  for _, diagnostic in ipairs(diagnostics) do
    table.insert(texts, diagnostic["message"])
    width = vim.fn.max({ width, vim.fn.len(diagnostic["message"]) })
  end

  vim.fn["ddu#start"]({
    sourceParams = {
      ["custom-list"] = {
        texts = texts,
      },
    },
    sources = { { name = "custom-list" } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = "Diagnostics",
        floatingTitlePos = "left",
        ignoreEmpty = true,
      },
    },
  })
end

M.gitsigns_actions = function()
  local actions = require("gitsigns.actions").get_actions()
  if actions == nil then
    return
  end
  local texts = {}
  local width = 1
  for k, _ in pairs(actions) do
    table.insert(texts, k)
    width = vim.fn.max({ width, vim.fn.len(k) })
  end

  local callbackId = vim.fn["denops#callback#register"](function(s)
    vim.fn.execute("Gitsigns " .. s)
  end, { once = true })

  vim.fn["ddu#start"]({
    sourceParams = {
      ["custom-list"] = {
        texts = texts,
        callbackId = callbackId,
      },
    },
    sources = { { name = "custom-list" } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = "Git actions",
        floatingTitlePos = "left",
        ignoreEmpty = true,
      },
    },
  })
end

M.chatgpt_run = function()
  local completion = vim.fn["getcompletion"]("ChatGPTRun ", "cmdline")
  if completion == nil then
    return
  end
  local width = 1
  for _, v in pairs(completion) do
    width = vim.fn.max({ width, vim.fn.len(v) })
  end

  local callbackId = vim.fn["denops#callback#register"](function(s)
    vim.fn.execute("'<,'>ChatGPTRun " .. s)
  end, { once = true })

  vim.fn["ddu#start"]({
    sourceParams = {
      ["custom-list"] = {
        texts = completion,
        callbackId = callbackId,
      },
    },
    sources = { { name = "custom-list" } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = "ChatGPTRun actions",
        floatingTitlePos = "left",
        ignoreEmpty = true,
      },
    },
  })
end

M.ssh = function()
  vim.fn["ddu#start"]({
    sourceOptions = {
      ssh = {
        path = vim.fn.expand("~/.ssh"),
        converters = { "converter_remove_display" },
      },
    },
    sourceParams = {
      ssh = {
        input = "Host ",
      },
    },
    sources = { { name = "ssh" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
    kindOptions = {
      file = {
        defaultAction = "attach",
      },
    },
  })
end

M.cheat = function()
  vim.fn["ddu#start"]({
    sourceOptions = {
      rg = {
        path = vim.env.CHEATDIR,
        converters = { "converter_remove_display" },
      },
    },
    sourceParams = {
      rg = {
        input = "## ",
      },
    },
    sources = { { name = "rg" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
    kindOptions = {
      file = {
        defaultAction = "open",
      },
    },
  })
end

M.note = function()
  vim.fn["ddu#start"]({
    sourceParams = {
      file_external = {
        cmd = { "fd", ".md", vim.env.NOTEDIR, "-t", "f" },
      },
    },
    sources = { { name = "file_external" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.minutes = function()
  vim.fn["ddu#start"]({
    sourceParams = {
      file_external = {
        cmd = { "fd", ".md", vim.env.MINUTESDIR, "-t", "f" },
      },
    },
    sources = { { name = "file_external" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.old_files = function()
  vim.fn["ddu#start"]({
    sources = { { name = "mr" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.find_files = function()
  vim.fn["ddu#start"]({
    sources = { { name = "file_external" } },
    uiParams = {
      ff = {
        startAutoAction = true,
        startFilter = true,
      },
    },
  })
end

M.old_repos = function()
  vim.fn["ddu#start"]({
    sourceParams = {
      mr = {
        kind = "mrr",
      },
    },
    sources = { { name = "mr" } },
  })
end

M.old_command = function()
  vim.fn["ddu#start"]({
    sources = { { name = "command_history" } },
  })
end

M.register = function()
  vim.fn["ddu#start"]({
    sources = { { name = "register" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.live_grep = function()
  vim.fn["ddu#start"]({
    sources = { { name = "rg" } },
    sourceOptions = {
      rg = {
        volatile = true,
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
        startFilter = true,
      },
    },
  })
end

M.grep_string = function()
  vim.fn["ddu#start"]({
    sources = { { name = "rg" } },
    sourceParams = {
      rg = {
        input = vim.fn.expand("<cword>"),
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
        ignoreEmpty = true,
      },
    },
  })
end

M.grep_pattern = function()
  vim.fn["ddu#start"]({
    sources = { { name = "rg" } },
    sourceParams = {
      rg = {
        input = vim.fn.input("Pattern: "),
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
        ignoreEmpty = true,
      },
    },
  })
end

M.buffer = function()
  vim.fn["ddu#start"]({
    sources = { { name = "buffer" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.help = function()
  vim.fn["ddu#start"]({
    sources = { { name = "help" } },
    uiParams = {
      ff = {
        startAutoAction = true,
        startFilter = true,
      },
    },
  })
end

M.colorscheme = function()
  vim.fn["ddu#start"]({
    sources = { { name = "colorscheme" } },
    uiParams = {
      ff = {
        autoAction = {
          name = "itemAction",
        },
      },
    },
  })
end

M.markdown = function()
  vim.fn["ddu#start"]({
    sources = { { name = "markdown" } },
    uiParams = {
      ff = {
        startAutoAction = true,
        filterFloatingTitle = "matcher: kensaku",
      },
    },
  })
end

M.nvim_notify = function()
  vim.fn["ddu#start"]({
    sources = { { name = "nvim-notify" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.ddu_source = function()
  vim.fn["ddu#start"]({
    sources = { { name = "source" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.git_status = function()
  vim.fn["ddu#start"]({
    sources = { { name = "git_status" } },
    sourceOptions = {
      git_status = {
        path = vim.fn.expand("%:p"),
        converters = { "converter_git_status" },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.git_log = function()
  vim.fn["ddu#start"]({
    sources = { { name = "git_log" } },
    sourceParams = {
      git_log = {
        showGraph = true,
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.git_diff = function()
  vim.fn["ddu#start"]({
    sources = { { name = "git_diff" } },
    sourceOptions = {
      git_diff = {
        path = vim.fn.expand("%:p"),
      },
    },
  })
end

M.git_branch = function()
  vim.fn["ddu#start"]({
    sources = { { name = "git_branch" } },
    sourceParams = {
      git_branch = {
        remote = true,
      },
    },
  })
end

M.ghq = function()
  vim.fn["ddu#start"]({
    sources = { { name = "ghq" } },
    sourceParams = {
      git_log = {
        showGraph = true,
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
        autoAction = {
          name = "preview",
          params = {
            previewCmds = { "onefetch", "%s" },
          },
        },
      },
    },
  })
end

M.lazy_nvim = function()
  vim.fn["ddu#start"]({
    sources = { { name = "lazy_nvim" } },
    uiParams = {
      ff = {
        startFilter = true,
      },
    },
  })
end

M.line = function()
  vim.fn["ddu#start"]({
    sources = { { name = "line" } },
    uiParams = {
      ff = {
        startFilter = true,
        startAutoAction = true,
      },
    },
  })
end

M.tab = function()
  vim.fn["ddu#start"]({
    sources = { { name = "tab" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.go_task = function()
  vim.fn["ddu#start"]({
    sources = { { name = "go_task" } },
    sourceOptions = {
      go_task = {
        defaultAction = "run",
      },
    },
  })
end

M.lsp_diagnostic = function()
  vim.fn["ddu#start"]({
    sources = { { name = "lsp_diagnostic" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.lsp_codeAction = function()
  vim.fn["ddu#start"]({
    sources = { { name = "lsp_codeAction" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.lsp_documentSymbol = function()
  vim.fn["ddu#start"]({
    sources = { { name = "lsp_documentSymbol" } },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

return M
