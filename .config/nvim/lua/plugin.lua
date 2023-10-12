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
  {
    "akinsho/toggleterm.nvim",
    event = "VimEnter",
    config = function()
      require("config.toggleterm")
    end,
  },
  "rebelot/kanagawa.nvim",
  "catppuccin/nvim",
  {
    "EdenEast/nightfox.nvim",
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
  {
    "cohama/lexima.vim",
    config = function()
      vim.g.lexima_ctrlh_as_backspace = 1
    end,
  },
  "machakann/vim-sandwich",
  "simeji/winresizer",
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
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("config.gitsigns")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    config = function()
      require("config.lualine")
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
  "lambdalisue/mr.vim",
  {
    "lambdalisue/kensaku-search.vim",
    dependencies = {
      "lambdalisue/kensaku.vim",
    },
    config = function()
      vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>", opt)
    end,
  },
  {
    "lambdalisue/kensaku-search.vim",
    dependencies = {
      "lambdalisue/kensaku.vim",
    },
    config = function()
      vim.keymap.set("c", "<CR>", "<Plug>(kensaku-search-replace)<CR>")
    end,
  },
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
    "akinsho/bufferline.nvim",
    event = "VimEnter",
    config = function()
      require("config.bufferline")
    end,
  },
  {
    "uga-rosa/translate.nvim",
    config = function()
      require("config.translate")
    end,
  },
  {
    "xiyaowong/nvim-cursorword",
    config = function()
      vim.api.nvim_command("hi default CursorWord cterm=underline gui=underline")
    end,
  },
  {
    "Shougo/ddu.vim",
    event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddu-commands.vim",
      "Shougo/ddu-ui-ff",
      "Shougo/ddu-ui-filer",
      "Shougo/ddu-kind-file",
      "Shougo/ddu-kind-word",
      "Shougo/ddu-source-file",
      "Shougo/ddu-source-action",
      "Shougo/ddu-source-file_rec",
      "Shougo/ddu-source-file_old",
      "Shougo/ddu-source-dummy",
      "liquidz/ddu-source-custom-list",
      "flow6852/ddu-source-qf",
      "kamecha/ddu-source-jumplist",
      "kamecha/ddu-source-floaterm",
      "kamecha/ddu-source-window",
      "kamecha/ddu-source-tab",
      "kamecha/ddu-filter-converter_highlight",
      "mikanIchinose/ddu-source-markdown",
      "kuuote/ddu-source-mr",
      "kuuote/ddu-source-git_diff",
      "kuuote/ddu-source-git_status",
      "kyoh86/ddu-source-git_log",
      "kyoh86/ddu-source-git_branch",
      "kyoh86/ddu-source-lazy_nvim",
      "Shougo/ddu-source-register",
      "Shougo/ddu-source-line",
      "matsui54/ddu-source-help",
      "matsui54/ddu-source-dein_update",
      "matsui54/ddu-source-man",
      "matsui54/ddu-source-file_external",
      "matsui54/ddu-source-command_history",
      "shutils/ddu-source-go_task",
      "shutils/ddu-source-taskwarrior",
      "shutils/ddu-filter-converter_dir_omit_middle",
      "shutils/ddu-filter-converter_remove_display",
      "shutils/ddu-filter-converter_tab",
      "shun/ddu-source-buffer",
      "shun/ddu-source-rg",
      "4513ECHO/vim-readme-viewer",
      "4513ECHO/ddu-source-ghq",
      "4513ECHO/ddu-source-source",
      "4513ECHO/ddu-source-colorscheme",
      "k-ota106/ddu-source-marks",
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
  {
    "Shougo/ddc.vim",
    event = "VimEnter",
    dependencies = {
      "vim-denops/denops.vim",
      "Shougo/ddc-source-nvim-lsp",
      "Shougo/ddc-around",
      "Shougo/ddc-ui-native",
      "Shougo/ddc-ui-pum",
      "Shougo/ddc-source-around",
      "Shougo/ddc-source-input",
      "Shougo/ddc-matcher_head",
      "Shougo/ddc-sorter_rank",
      "Shougo/ddc-source-cmdline",
      "Shougo/ddc-source-cmdline-history",
      "uga-rosa/ddc-source-vsnip",
      "LumaKernel/ddc-source-file",
      "tani/ddc-fuzzy",
      "Shougo/pum.vim",
      "vim-skk/skkeleton",
    },
    config = function()
      require("config.ddc")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
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
  {
    "jmcantrell/vim-virtualenv",
    cmd = { "VirtualEnvList", "VirtualEnvDeactivate", "VirtualEnvActivate" },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("todo-comments").setup({})
    end,
  },
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
  {
    "NeogitOrg/neogit",
    config = function()
      require("neogit").setup({})
      vim.keymap.set("n", "<Leader>gg", "<Cmd>Neogit<CR>", opt)
    end,
  },
  {
    "folke/flash.nvim",
    config = function()
      require("config.flash")
    end,
  },
  {
    "tyru/open-browser.vim",
    config = function()
      require("config.open-browser")
    end,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({})
    end,
  },
  {
    "hrsh7th/vim-vsnip",
    event = "VimEnter",
    config = function()
      vim.g.vsnip_snippet_dir = vim.env.CONF_DIR .. "/vsnip"
      vim.keymap.set("i", "<Tab>", function()
        return vim.fn["vsnip#jumpable"](1) == 1 and "<Plug>(vsnip-jump-next)" or "<Tab>"
      end, { expr = true })
      vim.keymap.set("i", "<S-Tab>", function()
        return vim.fn["vsnip#jumpable"](-1) == 1 and "<Plug>(vsnip-jump-prev)" or "<S-Tab>"
      end, { expr = true })
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTRun" },
    keys = { "<Leader>tk", "<Leader>cr" },
    enable = vim.env.OPENAI_API_KEY ~= nil,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("config.ChatGPT")
    end,
  },
  "dstein64/vim-startuptime",
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("ibl").setup()
    end,
  },
})
