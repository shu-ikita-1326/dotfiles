local autocmd = vim.api.nvim_create_autocmd

local function ddu_highlight_setting()
  vim.cmd([[highlight DduRed guifg=red]])
  vim.cmd([[highlight DduLightBlue guifg=lightblue]])
  vim.cmd([[highlight DduYellow guifg=yellow]])
  vim.cmd([[highlight DduGreen guifg=green]])
end

ddu_highlight_setting()

local function ddu_customs_setting()
  vim.fn["ddu#custom#alias"]('ui', 'ff_ghq', 'ff')
  vim.fn["ddu#custom#alias"]('ui', 'ff_colorscheme', 'ff')
  vim.fn["ddu#custom#alias"]('source', 'ssh', 'rg')
  vim.fn["ddu#custom#action"]('source', 'ssh', 'attach', function(args)
    vim.fn.execute("tabnew | terminal ssh " .. vim.fn.matchstr(args["items"][1]["action"]["text"], '\\s\\(\\S*\\)$'))
    return 0
  end)
end

ddu_customs_setting()

local function ddu_global_setting()
  vim.fn["ddu#custom#patch_global"]({
    ui = 'ff',
    filterParams = {
      matcher_fzf = {
        highlightMatched = 'Search',
      },
      converter_dir_omit_middle = {
        maxDirLength = 30,
      },
      matcher_kensaku = {
        highlightMatched = 'Search',
      },
      converter_devicon = {
        specificFileIcons = {
          devDockerfile = {
            icon = '',
          },
          Dockerfile = {
            icon = '',
          },
        },
        extentionIcons = {
          txt = {
            icon = '',
          },
          svg = {
            icon = '',
          },
          ps1 = {
            icon = '',
          },
          log = {
            icon = '',
          },
        },
      },
    },
    sources = { { name = 'file_rec', params = {} } },
    sourceParams = {
      file_external = {
        cmd = { 'fd', '.', '-H', '-E', '__pycache__', '-E', '.git', '-t', 'f' },
      },
      taskwarrior = {
        cmdName = 'taskw',
        filter = { 'status:completed', 'or', 'status:pending' },
      },
    },
    sourceOptions = {
      _ = {
        matchers = { 'matcher_fzf' },
        sorters = { 'sorter_fzf' },
        ignoreCase = true,
      },
      lsp_diagnostic = {
        converters = { 'converter_lsp_diagnostic' },
      },
      lsp_documentSymbol = {
        converters = { 'converter_lsp_symbol' },
      },
      lsp_workspaceSymbol = {
        converters = { 'converter_lsp_symbol' },
      },
      git_status = {
        converters = { 'converter_git_status' },
      },
      git_branch = {
        columns = { 'git_branch_head', 'git_branch_remote', 'git_branch_name', 'git_branch_upstream',
          'git_branch_author', },
      },
      file = {
        converters = { 'converter_relativepath', 'converter_devicon' },
      },
      file_rec = {
        converters = { 'converter_relativepath', 'converter_devicon' },
      },
      mr = {
        converters = { 'converter_relativepath', 'converter_dir_omit_middle', 'converter_devicon' },
      },
      file_external = {
        converters = { 'converter_relativepath', 'converter_devicon' },
      },
      taskwarrior = {
        converters = { 'converter_taskwarrior' },
        sorters = { 'sorter_taskwarrior' },
      },
      markdown = {
        matchers = { 'matcher_kensaku' },
      },
    },
    kindOptions = {
      file = {
        defaultAction = 'open',
      },
      man = {
        defaultAction = 'open',
      },
      word = {
        defaultAction = 'append',
      },
      command_history = {
        defaultAction = 'execute',
      },
      help = {
        defaultAction = 'open',
      },
      readme_viewer = {
        defaultAction = 'open',
      },
      git_status = {
        defaultAction = 'open',
      },
      git_branch = {
        defaultAction = 'switch',
      },
      ghq = {
        defaultAction = 'open',
      },
      lsp = {
        defaultAction = 'open',
      },
      lsp_codeAction = {
        defaultAction = 'apply',
      },
      action = {
        defaultAction = 'do',
      },
      ['nvim-notify'] = {
        defaultAction = 'open',
      },
      source = {
        defaultAction = 'execute',
      },
      colorscheme = {
        defaultAction = 'set',
      },
      dein_update = {
        defaultAction = 'viewDiff',
      },
      floaterm = {
        defaultAction = 'open',
      },
      window = {
        defaultAction = 'open',
      },
      tab = {
        defaultAction = 'open',
      },
      ['custom-list'] = {
        defaultAction = 'callback',
      },
      go_task = {
        defaultAction = 'run',
      },
      taskwarrior = {
        defaultAction = 'done',
      },
    },
    actionOptions = {
      echo = {
        quit = false,
      },
      echoDiff = {
        quit = false,
      },
      set = {
        quit = false,
      },
    },
    actionParams = {
      run = {
        prefix = "TermExec cmd='",
        suffix = "'",
      },
    },
    columnParams = {
      icon_filename = {
        customFileIcons = {
          lua = { icon = '' },
          txt = { icon = '' },
          vue = { icon = '' },
        },
      },
    },
    uiParams = {
      _ = {
        filterSplitDirection = 'floating',
        split = 'floating',
        filterFloatingPosition = 'top',
        floatingBorder = 'rounded',
        previewFloating = true,
        previewSplit = 'vertical',
        previewFloatingBorder = 'rounded',
        previewFloatingTitle = 'Preview',
        previewFloatingTitlePos = 'center',
        floatingTitle = 'Result',
        floatingTitlePos = 'center',
        filterFloatingTitle = 'matcher: fzf',
      },
      ff = {
        autoAction = {
          name = 'preview',
        },
      },
      ff_colorscheme = {
        autoAction = {
          name = 'itemAction',
        },
      },
      ff_ghq = {
        autoAction = {
          name = 'preview',
          params = {
            previewCmds = { 'onefetch', '%s' }
          },
        },
      },
      filer = {
        sortTreesFirst = true,
      },
    },
  })
end

ddu_global_setting()

local function layout_setting()
  local columns = vim.api.nvim_get_option('columns')
  local lines = vim.api.nvim_get_option('lines')

  local function wide_layout(columns, lines)
    return {
      winCol = math.floor((columns - (columns * 0.9)) / 2),
      winWidth = math.floor(columns * 0.9),
      winRow = 5,
      winHeight = lines - 8,
      previewCol = math.floor(columns / 2),
      previewWidth = math.floor((columns * 0.9) / 2 - 1),
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

  if columns < 200 then
    vim.fn["ddu#custom#patch_global"]('uiParams', {
      _ = narrow_layout(columns, lines)
    })
  else
    vim.fn["ddu#custom#patch_global"]('uiParams', {
      _ = wide_layout(columns, lines)
    })
  end
end

layout_setting()

autocmd("VimResized", {
  pattern = "*",
  callback = layout_setting,
})

local function start_lsp_def()
  vim.fn["ddu#start"]({
    ui = "ff",
    uiParams = {
      ff = {
        startAutoAction = true,
        autoAction = {
          name = "preview",
        }
      }
    },
    sources = {
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduRed",
              }
            }
          }
        },
        params = {
          display = ">>Definition<<",
        }
      },
      {
        name = "lsp_definition",
        params = {
          method = "textDocument/definition",
        }
      },
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduLightBlue",
              }
            }
          }
        },
        params = {
          display = ">>typeDefinition<<",
        }
      },
      {
        name = "lsp_definition",
        params = {
          method = "textDocument/typeDefinition",
        }
      },
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduYellow",
              }
            }
          }
        },
        params = {
          display = ">>declaration<<",
        }
      },
      {
        name = "lsp_definition",
        params = {
          method = "textDocument/declaration",
        }
      },
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduGreen",
              }
            }
          }
        },
        params = {
          display = ">>Implementation<<",
        }
      },
      {
        name = "lsp_definition",
        params = {
          method = "textDocument/implementation",
        }
      },
    }
  })
end

local function start_lsp_ref()
  vim.fn["ddu#start"]({
    ui = "ff",
    uiParams = {
      ff = {
        startAutoAction = true,
        autoAction = {
          name = "preview",
        }
      }
    },
    sources = {
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduRed",
              }
            }
          }
        },
        params = {
          display = ">>incomingCalls<<",
        }
      },
      {
        name = "lsp_callHierarchy",
        params = {
          method = "callHierarchy/incomingCalls",
        }
      },
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduLightBlue",
              }
            }
          }
        },
        params = {
          display = ">>outgoingCalls<<",
        }
      },
      {
        name = "lsp_callHierarchy",
        params = {
          method = "callHierarchy/outgoingCalls",
        }
      },
      {
        name = "dummy",
        options = {
          converters = {
            {
              name = "converter_highlight",
              params = {
                hl_group = "DduYellow",
              }
            }
          }
        },
        params = {
          display = ">>Reference<<",
        }
      },
      {
        name = "lsp_references",
      },
    }
  })
end

local function start_line_diagnostics()
  local diagnostics = vim.lsp.diagnostic.get_line_diagnostics(0)
  local texts = {}
  local width = 1
  for _, diagnostic in ipairs(diagnostics) do
    table.insert(texts, diagnostic["message"])
    width = vim.fn.max({ width, vim.fn.len(diagnostic["message"]) })
  end

  vim.fn["ddu#start"]({
    sourceParams = {
      ['custom-list'] = {
        texts = texts,
      },
    },
    sources = { { name = 'custom-list' } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = 'Diagnostics',
        floatingTitlePos = 'left',
        ignoreEmpty = true,
      }
    },
  })
end

local function start_gitsigns_actions()
  local actions = require('gitsigns.actions').get_actions()
  if actions == nil then
    return
  end
  local texts = {}
  local width = 1
  for k, _ in pairs(actions) do
    table.insert(texts, k)
    width = vim.fn.max({ width, vim.fn.len(k) })
  end

  local callbackId = vim.fn["denops#callback#register"](
    function(s)
      vim.fn.execute('Gitsigns ' .. s)
    end,
    { once = true }
  )

  vim.fn["ddu#start"]({
    sourceParams = {
      ['custom-list'] = {
        texts = texts,
        callbackId = callbackId
      },
    },
    sources = { { name = 'custom-list' } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = 'Git actions',
        floatingTitlePos = 'left',
        ignoreEmpty = true,
      }
    },
  })
end

local function start_chatgpt_run()
  local completion = vim.fn["getcompletion"]("ChatGPTRun ", "cmdline")
  if completion == nil then
    return
  end
  local width = 1
  for _, v in pairs(completion) do
    width = vim.fn.max({ width, vim.fn.len(v) })
  end

  local callbackId = vim.fn["denops#callback#register"](
    function(s)
      vim.fn.execute("'<,'>ChatGPTRun " .. s)
    end,
    { once = true }
  )

  vim.fn["ddu#start"]({
    sourceParams = {
      ['custom-list'] = {
        texts = completion,
        callbackId = callbackId
      },
    },
    sources = { { name = 'custom-list' } },
    uiParams = {
      ff = {
        autoResize = true,
        winRow = vim.fn.screenrow() - 1,
        winCol = vim.fn.screencol(),
        winWidth = width + 3,
        floatingTitle = 'ChatGPTRun actions',
        floatingTitlePos = 'left',
        ignoreEmpty = true,
      }
    },
  })
end

local function start_ssh()
  vim.fn["ddu#start"]({
    sourceOptions = {
      ssh = {
        path = vim.fn.expand('~/.ssh'),
      },
    },
    sourceParams = {
      ssh = {
        input = 'Host ',
      },
    },
    sources = { { name = 'ssh' } },
    uiParams = {
      ff = {
        startAutoAction = true,
      }
    },
    kindOptions = {
      file = {
        defaultAction = 'attach',
      }
    },
  })
end

local function start_cheat()
  vim.fn["ddu#start"]({
    sourceOptions = {
      rg = {
        path = vim.env.CHEATDIR,
      },
    },
    sourceParams = {
      rg = {
        input = '## ',
      },
    },
    sources = { { name = 'rg' } },
    uiParams = {
      ff = {
        startAutoAction = true,
      }
    },
    kindOptions = {
      file = {
        defaultAction = 'open',
      }
    },
  })
end

local function start_note()
  vim.fn["ddu#start"]({
    sourceParams = {
      file_external = {
        cmd = { 'fd', '.md', vim.env.NOTEDIR, '-t', 'f' },
      },
    },
    sources = { { name = 'file_external' } },
    uiParams = {
      ff = {
        startAutoAction = true,
      }
    },
  })
end

local function start_minutes()
  vim.fn["ddu#start"]({
    sourceParams = {
      file_external = {
        cmd = { 'fd', '.md', vim.env.MINUTESDIR, '-t', 'f' },
      },
    },
    sources = { { name = 'file_external' } },
    uiParams = {
      ff = {
        startAutoAction = true,
      }
    },
  })
end

local function ddu_key_mapping()
  local opt = { silent = true, noremap = true }
  vim.keymap.set("n", "<Leader>hh", "<Cmd>Ddu -ui=ff mr -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>ff",
    "<Cmd>Ddu -ui=ff file_external -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>", opt)
  vim.keymap.set("n", "<Leader>hp",
    "<Cmd>Ddu -ui=ff mr -source-param-ff-kind=mrr<CR>", opt)
  vim.keymap.set("n", "<Leader>fr",
    "<Cmd>Ddu -ui=ff register -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>/",
    "<Cmd>Ddu -ui=ff rg -source-option-ff-volatile=v:true -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>",
    opt)
  vim.keymap.set("n", "<Leader>*",
    "<Cmd>Ddu -ui=ff rg -resume=v:false -ui-param-ff-startAutoAction -ui-param-ff-ignoreEmpty -source-param-ff-input=`('<cword>'->expand())`<CR>",
    opt)
  vim.keymap.set("n", "<Leader>?",
    "<Cmd>Ddu -ui=ff rg -resume=v:false -ui-param-ff-startAutoAction -ui-param-ff-ignoreEmpty -source-param-ff-input=`input('Pattern: ')`<CR>",
    opt)
  vim.keymap.set("n", "<Leader>fb",
    "<Cmd>Ddu -ui=ff buffer -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fh",
    "<Cmd>Ddu -ui=ff help -ui-param-ff-startAutoAction -ui-param-ff-startFilter=v:true<CR>", opt)
  vim.keymap.set("n", "<Leader>co",
    "<Cmd>Ddu -ui=ff_colorscheme colorscheme<CR>", opt)
  vim.keymap.set("n", "<Leader>fm",
    "<Cmd>Ddu -ui=ff markdown -ui-param-ff-startAutoAction -ui-param-ff-filterFloatingTitle='matcher: kensaku'<CR>", opt)
  vim.keymap.set("n", "<Leader>fn",
    "<Cmd>Ddu -ui=ff nvim-notify -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fj",
    "<Cmd>Ddu -ui=ff jumplist -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fs",
    "<Cmd>Ddu -ui=ff source -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>gs",
    "<Cmd>Ddu -ui=ff git_status -source-option-ff-path=`expand('%:p')` -source-option-ff-converter='converter_git_status' -ui-param-ff-startAutoAction<CR>",
    opt)
  vim.keymap.set("n", "<Leader>gd",
    "<Cmd>Ddu -ui=ff git_diff -source-option-ff-path=`expand('%:p')`<CR>", opt)
  vim.keymap.set("n", "<Leader>gb",
    "<Cmd>Ddu -ui=ff git_branch -source-param-ff-remote=v:true<CR>", opt)
  vim.keymap.set("n", "<Leader>gl",
    "<Cmd>Ddu -ui=ff git_log -source-param-ff-showGraph -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>gh",
    "<Cmd>Ddu -ui=ff ghq -ui='ff_ghq' -ui-param-ff_ghq-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fd",
    "<Cmd>Ddu -ui=ff lazy_nvim -ui-param-ff-startFilter=v:true<CR>", opt)
  vim.keymap.set("n", "<Leader>fl",
    "<Cmd>Ddu -ui=ff line -ui-param-ff-startFilter=v:true -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>ftt",
    "<Cmd>Ddu -ui=ff tab -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fte",
    "<Cmd>Ddu -name=floaterm -ui=ff floaterm -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>fta",
    "<Cmd>Ddu -ui=ff go_task -source-option-ff-defaultAction=run<CR>", opt)
  vim.keymap.set("n", "gd", start_lsp_def, opt)
  vim.keymap.set("n", "gs", start_lsp_ref, opt)
  vim.keymap.set("n", "ge",
    "<Cmd>Ddu -ui=ff lsp_diagnostic -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>ca",
    "<Cmd>Ddu -ui=ff lsp_codeAction -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "ds",
    "<Cmd>Ddu -ui=ff lsp_documentSymbol -ui-param-ff-startAutoAction<CR>", opt)
  vim.keymap.set("n", "<Leader>le", start_line_diagnostics, opt)
  vim.keymap.set("n", "<Leader>ga", start_gitsigns_actions, opt)
  vim.keymap.set("v", "<Leader>cr", start_chatgpt_run, opt)
  vim.keymap.set("n", "<Leader>ssh", start_ssh, opt)
  vim.keymap.set("n", "<Leader>ch", start_cheat, opt)
  vim.keymap.set("n", "<Leader>note", start_note, opt)
  vim.keymap.set("n", "<Leader>min", start_minutes, opt)
end

ddu_key_mapping()

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

local function ddu_ff_key_mapping()
  local maps = {
    { "n", "<CR>",  "itemAction" },
    { "n", "i",     "openFilterWindow" },
    { "n", "q",     "quit" },
    { "n", "<C-c>", "quit" },
    { "n", "a",     "chooseAction" },
    { "n", "d",     "itemAction",      { name = "delete" } },
    { "n", "p",     "togglePreview" },
    { "n", "<C-t>", "toggleAutoAction" },
    { "n", "<Tab>", "toggleSelectItem" },
    { "n", "A",     "toggleAllItems" },
  }
  for _, v in ipairs(maps) do
    util_ddu_key_mapper(v)
  end
end

autocmd("FileType", {
  pattern = "ddu-ff",
  callback = ddu_ff_key_mapping
})

local function ddu_ff_filter_key_mapping()
  local opt = { buffer = true }
  vim.keymap.set({ "n", "i" }, "<CR>", function()
    vim.fn["ddu#ui#do_action"]('closeFilterWindow')
    vim.cmd([[:stopinsert]])
  end, opt)
  vim.keymap.set({ "n", "i" }, "<C-c>", function()
    vim.fn["ddu#ui#do_action"]('quit')
    vim.cmd([[:stopinsert]])
  end, opt)
end

autocmd("FileType", {
  pattern = "ddu-ff-filter",
  callback = ddu_ff_filter_key_mapping
})
