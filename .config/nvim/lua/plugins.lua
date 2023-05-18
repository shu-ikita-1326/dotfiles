local fn = vim.fn
local autocmd = vim.api.nvim_create_autocmd

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
autocmd("BufWritePost", { pattern = "plugins.lua", command = ":source <afile> | PackerSync" })

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here

  use({ "wbthomason/packer.nvim" })
  use({ "nvim-lua/plenary.nvim" }) -- Common utilities

  -- Colorschemes
  use({ "EdenEast/nightfox.nvim" })
  use({ "rebelot/kanagawa.nvim" })

  use({ "nvim-lualine/lualine.nvim", config = [[require('config.lualine')]] })                   -- Statusline
  use({ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup({}) end, }) -- Autopairs, integrates with both cmp and treesitter
  use({ "kyazdani42/nvim-web-devicons", config = [[require('config.devicons')]] })               -- File icons
  use({ "akinsho/bufferline.nvim", config = [[require('config.bufferline')]] })

  -- cmp plugins
  use({
    "hrsh7th/nvim-cmp",
    module = { "cmp" },
    requires = {
      { "hrsh7th/cmp-buffer",       event = { "InsertEnter" } },
      { "hrsh7th/cmp-path",         event = { "InsertEnter" } },
      { "hrsh7th/cmp-cmdline",      event = { "CmdlineEnter" } },
      { "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
      { "hrsh7th/cmp-nvim-lua",     event = { "InsertEnter" } },
      { "hrsh7th/cmp-nvim-lsp",     event = { "InsertEnter" } },
      { "onsails/lspkind-nvim",     event = { "InsertEnter" } },
    },
    config = [[require('config.cmp')]],
  }) -- The completion plugin

  -- snippets
  use({ "L3MON4D3/LuaSnip", module = { "luasnip" }, config = [[require('config.luasnip')]] }) --snippet engine

  -- LSP
  use({
    "williamboman/mason.nvim",
    event = { "VimEnter" },
    requires = {
      { "neovim/nvim-lspconfig",             opt = true },
      { "williamboman/mason-lspconfig.nvim", opt = true },
    },
    wants = {
      "nvim-lspconfig",
      "mason-lspconfig.nvim",
    },
    config = [[require('config.mason')]],
  }) -- simple to use language server installer
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "ThePrimeagen/refactoring.nvim",
      "lewis6991/gitsigns.nvim",
    },
    config = [[require('config.null-ls')]],
  })                                                                      -- for formatters and linters
  use({ "glepnir/lspsaga.nvim", config = [[require('config.lspsaga')]] }) -- LSP UIs

  -- Formatter
  use({ "MunifTanjim/prettier.nvim" })

  -- Telescope
  use({
    "nvim-telescope/telescope.nvim",
    module = { "telescope" },
    event = { "VimEnter" },
    requires = {
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = [[require('config.telescope')]],
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require('config.treesitter')]] })

  -- Filer
  use({
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = [[require('config.neo-tree')]],
  })

  -- Git
  use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] })
  use({ "TimUntersberger/neogit", config = [[require('config.neogit')]], requires = { "sindrets/diffview.nvim" } })
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim", config = [[require('config.diffview')]] })
  use({ "tpope/vim-fugitive" })

  -- easymotion
  use({ "ggandor/leap.nvim", config = [[require('config.leap')]] })

  -- comment
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  -- utility
  use({
    "kylechui/nvim-surround",
    config = function()
      require("nvim-surround").setup({})
    end,
  })
  use({ "akinsho/toggleterm.nvim", config = [[require('config.toggleterm')]] })
  use({ "uga-rosa/translate.nvim", config = [[require('config.translate')]] })
  use({ "junegunn/goyo.vim" })
  use({ "windwp/nvim-ts-autotag" })
  use({ "petertriho/nvim-scrollbar", config = [[require('config.nvim-scrollbar')]] })
  use({ "xiyaowong/nvim-cursorword", config = [[require('config/nvim-cursorword')]] })
  use({ "lukas-reineke/indent-blankline.nvim", config = [[require('config.indent-blankline')]] })
  use({ "karb94/neoscroll.nvim", config = [[require('config.neoscroll')]] })
  use({ "ray-x/lsp_signature.nvim", config = [[require('config.signature')]] })
  use({ "stevearc/oil.nvim", config = function() require("oil").setup() end })
  use({ "wellle/targets.vim" })
  use({ "tpope/vim-repeat" })
  use({ "simeji/winresizer" })
  use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim", config = [[require('config.todo-comments')]] })
  use({ "szw/vim-maximizer", config = [[require('config.maximizer')]] })
  use({ "xiyaowong/transparent.nvim", config = [[require('config.transparent')]] })
  use({ "monaqa/dial.nvim", config = [[require('config.dial')]] })

  -- outline
  use({ "stevearc/aerial.nvim", config = [[require('config.aerial')]] })

  -- chatGpt
  use({
    "jackMort/ChatGPT.nvim",
    event = { "VimEnter" },
    config = [[require('config.ChatGPT')]],
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  })

  -- notify
  use({
    "folke/noice.nvim",
    config = [[require('config.noice')]],
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  })

  -- diagnostic manager
  use({ "folke/trouble.nvim", requires = "nvim-tree/nvim-web-devicons", config = [[require('config.trouble')]] })

  -- quickfix
  use({ "kevinhwang91/nvim-bqf", ft = "qf" })

  -- refactoring
  use({
    "ThePrimeagen/refactoring.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  })

  -- browser
  use({ "tyru/open-browser.vim", config = [[require('config.open-browser')]] })

  -- markdown
  -- install without yarn or npm
  use({ "iamcco/markdown-preview.nvim", run = function() vim.fn["mkdp#util#install"]() end, })
  use({
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  })

  -- org mode
  use({
    "nvim-orgmode/orgmode",
    config = function()
      require("orgmode").setup({
        org_agenda_files = {"~/org/*.org"},
        win_split_mode = {'float', 0.9},
        org_default_notes_file = "~/org/refile.org",
      })
      require("orgmode").setup_ts_grammar()
    end,
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
