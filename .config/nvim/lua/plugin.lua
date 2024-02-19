local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opt = { silent = true, noremap = true }

require("lazy").setup({
  -- filer
  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("config.neo-tree")
    end,
  },
  {
    "stevearc/oil.nvim",
    event = "VimEnter",
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        keymaps = {
          ["<C-h>"] = false,
          ["<C-p>"] = false,
          ["<C-l>"] = false,
        },
      })
    end,
  },

  -- LSP manager
  {
    "williamboman/mason.nvim",
    event = "VimEnter",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("config.mason")
    end,
  },

  -- Diagnostic enhansment
  {
    "folke/trouble.nvim",
    event = "VimEnter",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    },
    config = function()
      require("config.trouble")
    end,
  },

  -- Fuzzy finder
  {
    "Shougo/ddu.vim",
    event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-commands.vim",
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-action",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-dummy",
      "Shougo/ddu-filter-sorter_alpha",
      "liquidz/ddu-source-custom-list",
      "flow6852/ddu-source-qf",
      "kamecha/ddu-source-tab",
      "kamecha/ddu-filter-converter_highlight",
      "kuuote/ddu-source-mr",
      "kyoh86/ddu-source-lazy_nvim",
      "Shougo/ddu-source-register",
      "Shougo/ddu-source-line",
      "matsui54/ddu-source-help",
      "matsui54/ddu-source-file_external",
      "matsui54/ddu-source-command_history",
      "shutils/ddu-source-go_task",
      "shutils/ddu-filter-converter_dir_omit_middle",
      "shutils/ddu-filter-converter_remove_display",
      "shutils/ddu-filter-converter_tab",
      "shun/ddu-source-buffer",
      "shun/ddu-source-rg",
      "4513ECHO/ddu-source-ghq",
      "4513ECHO/ddu-source-source",
      "Shougo/ddu-column-filename",
      "ryota2357/ddu-column-icon_filename",
      "Shougo/ddu-filter-matcher_substring",
      "uga-rosa/ddu-filter-converter_devicon",
      "gamoutatsumi/ddu-filter-converter_relativepath",
      "uga-rosa/ddu-source-lsp",
      "yuki-yano/ddu-filter-fzf",
      "yuki-yano/ddu-source-nvim-notify",
      "Milly/ddu-filter-kensaku",
      "Shougo/ddu.vim",
    },
    config = function()
      require("config.ddu")
    end,
  },

  -- Completion
  {
    "Shougo/ddc.vim",
    event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-source-lsp",
      "Shougo/ddc-around",
      "Shougo/ddc-ui-native",
      "Shougo/ddc-ui-pum",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-input",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-sorter_rank",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline-history",
      "uga-rosa/denippet.vim",
      "LumaKernel/ddc-source-file",
      "tani/ddc-fuzzy",
      "Shougo/pum.vim",
      "vim-skk/skkeleton",
    },
    config = function()
      require("config.ddc")
    end,
  },

  -- Snippet manager
  {
    "uga-rosa/denippet.vim",
    event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
      require("config.denippet")
    end,
  },
  "hrsh7th/vim-vsnip",

  -- Terminal manager
  {
    "akinsho/toggleterm.nvim",
    event = "VimEnter",
    config = function()
      require("config.toggleterm")
    end,
  },

  -- colorscheme
  "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },

  -- edit
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "hrsh7th/nvim-insx",
    config = function()
      require("config.insx")
    end,
  },
  "machakann/vim-sandwich",
  {
    "monaqa/dial.nvim",
    keys = { "<C-n>", "<C-p>" },
    config = function()
      require("config.dial")
    end,
  },
  {
    "stevearc/aerial.nvim",
    config = function()
      require("config.aerial")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  },
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({})
      vim.keymap.set("n", "<Leader>gg", "<Cmd>Neogit<CR>", opt)
    end,
  },
  {
    "sindrets/diffview.nvim",
    config = function()
      vim.keymap.set("n", "<Leader>do", "<Cmd>DiffviewOpen<CR>", opt)
      vim.keymap.set("n", "<Leader>dc", "<Cmd>DiffviewClose<CR>", opt)
    end,
  },
  {
    "shutils/gitlaber",
    dependencies = {
      "vim-denops/denops.vim",
    },
    config = function()
      require("config.gitlaber")
    end,
  },

  -- Visual
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.lualine")
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    config = function()
      require("config.bufferline")
    end,
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("config.noice")
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        strict = true,
        override_by_filename = {
          ["docker-compose.yml"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Dockerfile",
          },
          ["docker-compose.yaml"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Dockerfile",
          },
          [".dockerignore"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Dockerfile",
          },
          ["dockerfile"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Dockerfile",
          },
        },
        override_by_extension = {
          ["svg"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Svg",
          },
          ["log"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Log",
          },
          ["txt"] = {
            icon = "",
            color = "#458ee6",
            cterm_color = "68",
            name = "Txt",
          },
        },
      })
    end,
  },
  {
    "xiyaowong/nvim-cursorword",
    config = function()
      vim.api.nvim_command("hi default CursorWord cterm=underline gui=underline")
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({
        no_exec_files = {
          "vim",
        },
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup({
        scope = {
          enabled = false,
        },
      })
    end,
  },
  "psliwka/vim-smoothie",

  -- File and directory access manager
  "lambdalisue/mr.vim",

  -- Search feature enhansment
  {
    "lambdalisue/kensaku-search.vim",
    dependencies = {
      "lambdalisue/kensaku.vim",
    },
    config = function()
      vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")
    end,
  },

  -- Parsing
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VimEnter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("config.treesitter")
    end,
    build = function()
      vim.cmd([[TSUpdate]])
    end,
  },

  -- Utility
  {
    "uga-rosa/translate.nvim",
    config = function()
      require("config.translate")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
  {
    "tyru/open-browser.vim",
    config = function()
      require("config.open-browser")
    end,
  },
  "dstein64/vim-startuptime",

  -- Japanese input feature
  {
    "vim-skk/skkeleton",
    event = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged", "CmdlineEnter" },
    dependencies = {
      "vim-denops/denops.vim",
      "skk-dev/dict",
    },
    config = function()
      require("config.skkeleton")
    end,
  },
  {
    "delphinus/skkeleton_indicator.nvim",
    event = "VimEnter",
    dependencies = {
      "vim-skk/skkeleton",
    },
    config = function()
      require("skkeleton_indicator").setup({
        zindex = 300,
      })
    end,
  },

  -- Virtual environment management
  {
    "jmcantrell/vim-virtualenv",
  },

  -- Todo manager
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("todo-comments").setup({})
    end,
  },

  -- Motion enhansment
  {
    "folke/flash.nvim",
    config = function()
      require("config.flash")
    end,
  },

  -- AI
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    keys = { "<Leader>tk", "<Leader>cr" },
    enabled = vim.env.OPENAI_API_KEY ~= nil,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("config.ChatGPT")
    end,
  },

  -- Quickfix enhansment
  {
    "thinca/vim-qfreplace",
    config = function()
      vim.keymap.set("n", "<Leader>q", "<Cmd>Qfreplace<CR>", opt)
    end,
  },
  "itchyny/vim-qfedit",
  "kevinhwang91/nvim-bqf",

  -- Rest client
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = true,
      })
      vim.keymap.set("n", "<Leader>R", "<Plug>RestNvim", opt)
    end,
  },

  -- Task runner
  {
    "shutils/go-task.vim",
    config = function()
      vim.g.go_task_direction = "right"
      vim.keymap.set("n", "<Leader>ta", "<Cmd>GoTask<CR>", opt)
    end,
  },

  -- note
  {
    "shutils/dpskasten.vim",
    dependencies = {
      "vim-denops/denops.vim",
    },
  },
})
