local fn = vim.fn

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
vim.cmd([[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]])

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
	use({ "EdenEast/nightfox.nvim" }) -- Color scheme

	use({ "nvim-lualine/lualine.nvim", config = [[require('config.lualine')]] }) -- Statusline
	use({ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }) -- Autopairs, integrates with both cmp and treesitter
	use({ "kyazdani42/nvim-web-devicons" }) -- File icons
	use({ "akinsho/bufferline.nvim", config = function() require("bufferline").setup({})end, })

	-- cmp plugins
	use({ "hrsh7th/nvim-cmp",
    module = { "cmp" },
    requires = {
      { "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
      { "hrsh7th/cmp-path", event = { "InsertEnter" } },
      { "hrsh7th/cmp-cmdline", event = { "CmdlineEnter" } },
      { "saadparwaiz1/cmp_luasnip", event = { "InsertEnter" } },
      { "hrsh7th/cmp-nvim-lua", event = { "InsertEnter" } },
      { "hrsh7th/cmp-nvim-lsp", event = { "InsertEnter" } },
      { "onsails/lspkind-nvim", event = { "InsertEnter" } },
    },
    config = [[require('config.cmp')]],
  }) -- The completion plugin

	-- snippets
	use({ "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    config = [[require('config.luasnip')]],
  }) --snippet engine

	-- LSP
	use({ "williamboman/mason.nvim",
    event = { "VimEnter"},
    requires = {
      { "neovim/nvim-lspconfig", opt = true },
      { "williamboman/mason-lspconfig.nvim", opt = true },
    },
    wants = {
      "nvim-lspconfig",
      "mason-lspconfig.nvim",
    },
    config = [[require('config.mason')]],
  }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "glepnir/lspsaga.nvim", config = [[require('config.lspsaga')]], }) -- LSP UIs

	-- Formatter
	use({ "MunifTanjim/prettier.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim",
    module = { "telescope" },
    event = { "VimEnter" },
    requires = {
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = [[require('config.telescope')]],
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate", config = [[require('config.treesitter')]] } })

  -- Filer
  use({ "nvim-tree/nvim-tree.lua", config = [[require('config.nvim-tree')]], } )

  -- Git
  use({ "lewis6991/gitsigns.nvim", config = [[require('config.gitsigns')]] })
  use({ "tpope/vim-fugitive" })

  -- easymotion
  use({ "phaazon/hop.nvim", config = [[require('config.hop')]] })

  -- comment
  use({ "numToStr/Comment.nvim", config = function() require('Comment').setup()end })

  -- utility
  use({ "machakann/vim-sandwich" })
  use({ "akinsho/toggleterm.nvim", config = [[require('config.toggleterm')]] })
  use({ "skanehira/translate.vim", config = [[require('config.translate')]] })
  use({ "junegunn/goyo.vim" })
  use({ "windwp/nvim-ts-autotag" })

  -- outline
  use({ "stevearc/aerial.nvim", config = [[require('config.aerial')]] })

  -- chatGpt
  use({ "shutils/ChatGPT.nvim",
    commit = "485eecb",
    event = { "VimEnter" },
    config = [[require('config.ChatGPT')]],
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  -- notify
  use({
    "folke/noice.nvim",
    config = [[require('config.noice')]],
    requires = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  })

  use({ "lukas-reineke/indent-blankline.nvim", config = [[require('config.indent-blankline')]] })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

