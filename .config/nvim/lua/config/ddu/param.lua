local M = {}

M.global = {
  ui = "ff",
  filterParams = {
    matcher_fzf = {
      highlightMatched = "Search",
    },
    converter_dir_omit_middle = {
      maxDirLength = 30,
    },
    matcher_kensaku = {
      highlightMatched = "Search",
    },
    converter_devicon = {
      specificFileIcons = {
        devDockerfile = {
          icon = "",
        },
        Dockerfile = {
          icon = "",
        },
      },
      extentionIcons = {
        txt = {
          icon = "",
        },
        svg = {
          icon = "",
        },
        ps1 = {
          icon = "",
        },
        log = {
          icon = "",
        },
      },
    },
  },
  sources = { { name = "file_rec", params = {} } },
  sourceParams = {
    file_external = {
      cmd = { "fd", ".", "-H", "-E", "__pycache__", "-E", ".git", "-t", "f" },
    },
    taskwarrior = {
      cmdName = "taskw",
      filter = { "status:completed", "or", "status:pending" },
    },
  },
  sourceOptions = {
    _ = {
      matchers = { "matcher_fzf" },
      sorters = { "sorter_fzf" },
      ignoreCase = true,
    },
    lsp_diagnostic = {
      converters = { "converter_lsp_diagnostic" },
    },
    lsp_documentSymbol = {
      converters = { "converter_lsp_symbol" },
    },
    lsp_workspaceSymbol = {
      converters = { "converter_lsp_symbol" },
    },
    git_status = {
      converters = { "converter_git_status" },
    },
    git_branch = {
      columns = {
        "git_branch_head",
        "git_branch_remote",
        "git_branch_name",
        "git_branch_upstream",
        "git_branch_author",
      },
    },
    file = {
      converters = { "converter_relativepath", "converter_devicon" },
    },
    file_rec = {
      converters = { "converter_relativepath", "converter_devicon" },
    },
    mr = {
      converters = { "converter_relativepath", "converter_dir_omit_middle", "converter_devicon" },
    },
    file_external = {
      converters = { "converter_relativepath", "converter_devicon" },
    },
    taskwarrior = {
      converters = { "converter_taskwarrior" },
      sorters = { "sorter_taskwarrior" },
    },
    markdown = {
      matchers = { "matcher_kensaku" },
    },
  },
  kindOptions = {
    file = {
      defaultAction = "open",
    },
    man = {
      defaultAction = "open",
    },
    word = {
      defaultAction = "append",
    },
    command_history = {
      defaultAction = "execute",
    },
    help = {
      defaultAction = "open",
    },
    readme_viewer = {
      defaultAction = "open",
    },
    git_status = {
      defaultAction = "open",
    },
    git_branch = {
      defaultAction = "switch",
    },
    ghq = {
      defaultAction = "open",
    },
    lsp = {
      defaultAction = "open",
    },
    lsp_codeAction = {
      defaultAction = "apply",
    },
    action = {
      defaultAction = "do",
    },
    ["nvim-notify"] = {
      defaultAction = "open",
    },
    source = {
      defaultAction = "execute",
    },
    colorscheme = {
      defaultAction = "set",
    },
    dein_update = {
      defaultAction = "viewDiff",
    },
    floaterm = {
      defaultAction = "open",
    },
    window = {
      defaultAction = "open",
    },
    tab = {
      defaultAction = "open",
    },
    ["custom-list"] = {
      defaultAction = "callback",
    },
    taskwarrior = {
      defaultAction = "done",
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
        lua = { icon = "" },
        txt = { icon = "" },
        vue = { icon = "" },
      },
    },
  },
  uiParams = {
    _ = {
      filterSplitDirection = "floating",
      split = "floating",
      filterFloatingPosition = "top",
      floatingBorder = "rounded",
      previewFloating = true,
      previewSplit = "vertical",
      previewFloatingBorder = "rounded",
      previewFloatingTitle = "Preview",
      previewFloatingTitlePos = "center",
      floatingTitle = "Result",
      floatingTitlePos = "center",
      filterFloatingTitle = "matcher: fzf",
    },
    ff = {
      autoAction = {
        name = "preview",
      },
    },
  },
}

M.lsp_def = {
  ui = "ff",
  uiParams = {
    ff = {
      startAutoAction = true,
      autoAction = {
        name = "preview",
      },
    },
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
            },
          },
        },
      },
      params = {
        display = ">>Definition<<",
      },
    },
    {
      name = "lsp_definition",
      params = {
        method = "textDocument/definition",
      },
    },
    {
      name = "dummy",
      options = {
        converters = {
          {
            name = "converter_highlight",
            params = {
              hl_group = "DduLightBlue",
            },
          },
        },
      },
      params = {
        display = ">>typeDefinition<<",
      },
    },
    {
      name = "lsp_definition",
      params = {
        method = "textDocument/typeDefinition",
      },
    },
    {
      name = "dummy",
      options = {
        converters = {
          {
            name = "converter_highlight",
            params = {
              hl_group = "DduYellow",
            },
          },
        },
      },
      params = {
        display = ">>declaration<<",
      },
    },
    {
      name = "lsp_definition",
      params = {
        method = "textDocument/declaration",
      },
    },
    {
      name = "dummy",
      options = {
        converters = {
          {
            name = "converter_highlight",
            params = {
              hl_group = "DduGreen",
            },
          },
        },
      },
      params = {
        display = ">>Implementation<<",
      },
    },
    {
      name = "lsp_definition",
      params = {
        method = "textDocument/implementation",
      },
    },
  },
}

M.lsp_ref = {
  ui = "ff",
  uiParams = {
    ff = {
      startAutoAction = true,
      autoAction = {
        name = "preview",
      },
    },
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
            },
          },
        },
      },
      params = {
        display = ">>incomingCalls<<",
      },
    },
    {
      name = "lsp_callHierarchy",
      params = {
        method = "callHierarchy/incomingCalls",
      },
    },
    {
      name = "dummy",
      options = {
        converters = {
          {
            name = "converter_highlight",
            params = {
              hl_group = "DduLightBlue",
            },
          },
        },
      },
      params = {
        display = ">>outgoingCalls<<",
      },
    },
    {
      name = "lsp_callHierarchy",
      params = {
        method = "callHierarchy/outgoingCalls",
      },
    },
    {
      name = "dummy",
      options = {
        converters = {
          {
            name = "converter_highlight",
            params = {
              hl_group = "DduYellow",
            },
          },
        },
      },
      params = {
        display = ">>Reference<<",
      },
    },
    {
      name = "lsp_references",
    },
  },
}

return M
