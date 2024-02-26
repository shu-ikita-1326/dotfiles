local param = require("config.ddu.param")
local layout = require("config.ddu.layout")

local function custom_completion(comp_cmd, exec_cmd, f_title)
  local completion = vim.fn["getcompletion"](comp_cmd .. " ", "cmdline")
  if completion == nil then
    return
  end
  local width = 1
  for _, v in pairs(completion) do
    width = vim.fn.max({ width, vim.fn.len(v) })
  end

  local callbackId = vim.fn["denops#callback#register"](function(s)
    vim.fn.execute(exec_cmd .. " " .. s)
  end, { once = true })

  vim.fn["ddu#start"]({
    sources = {
      {
        name = "custom-list",
        params = {
          texts = completion,
          callbackId = callbackId,
        },
      },
    },
    uiParams = {
      ff = layout.on_cursor(width, f_title),
    },
  })
end

local M = {}

M.lsp_def = function()
  vim.fn["ddu#start"](param.lsp_def)
end

M.lsp_ref = function()
  vim.fn["ddu#start"](param.lsp_ref)
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
    sources = {
      {
        name = "custom-list",
        params = {
          texts = texts,
          callbackId = callbackId,
        },
      },
    },
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
  custom_completion("ChatGPTRun", "'<,'>ChatGPTRun ", "ChatGPTRun actions")
end

M.ssh = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "ssh",
        params = {
          input = "Host ",
        },
        options = {
          path = vim.fn.expand("~/.ssh"),
          converters = {
            "converter_remove_display",
          },
        },
      },
    },
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
    sources = {
      {
        name = "rg",
        params = {
          input = "## ",
        },
        options = {
          path = vim.env.CHEATDIR,
          converters = {
            "converter_remove_display",
          },
        },
      },
    },
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

M.obsidian_note = function(tag)
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "obsidian_note",
        params = {
          vault = vim.fn.expand("~/zettelkasten"),
          tag = tag,
        },
        options = {
          matchers = { "converter_obsidian_rel_path", "converter_obsidian_title", "converter_display_word", "matcher_fzf" },
          sorters = { "converter_obsidian_rel_path", "converter_obsidian_title", "converter_display_word", "sorter_fzf" },
        },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.obsidian_note_filer = function()
  vim.fn["ddu#start"]({
    ui = "filer",
    sources = {
      {
        name = "obsidian_note",
        params = {
          vault = vim.fn.expand("~/zettelkasten"),
        },
        options = {
          sorters = { "converter_obsidian_rel_path", "converter_obsidian_title", "converter_display_word", "sorter_alpha" },
        },
      },
    },
    uiParams = {
      filer = {
        displayRoot = false,
      },
    },
  })
end

M.obsidian_tag = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "obsidian_tag",
        params = {
          vault = vim.fn.expand("~/zettelkasten"),
        },
        options = {
          sorters = { "sorter_alpha" },
          defaultAction = "findNotes",
        },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.note = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "file_external",
        params = {
          cmd = { "fd", ".md", vim.env.NOTEDIR, "-t", "f" },
        },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.minutes = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "file_external",
        params = {
          cmd = { "fd", ".md", vim.env.MINUTESDIR, "-t", "f" },
        },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.old_files = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "mr",
        params = {
          kind = "mrw",
        },
      },
    },
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
    sources = {
      {
        name = "mr",
        params = {
          kind = "mrr",
        },
      },
    },
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
    sources = {
      {
        name = "rg",
        options = {
          volatile = true,
        },
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
    sources = {
      {
        name = "rg",
        params = {
          input = vim.fn.expand("<cword>"),
        },
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
    sources = {
      {
        name = "rg",
        params = {
          input = vim.fn.input("Pattern: "),
        },
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

M.ghq = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "ghq",
        params = {
          showGraph = true,
        },
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
    sources = {
      {
        name = "tab",
        options = {
          converters = { "converter_tab" },
        },
      },
    },
    uiParams = {
      ff = {
        startAutoAction = true,
      },
    },
  })
end

M.go_task = function()
  vim.fn["ddu#start"]({
    sources = {
      {
        name = "go_task",
        options = {
          defaultAction = "run",
        },
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

M.virtualenvs = function()
  custom_completion("VirtualEnvActivate", "VirtualEnvActivate", "VirtualEnv activate")
end

return M
