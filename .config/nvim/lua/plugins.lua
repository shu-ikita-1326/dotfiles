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
	use({ "tomasr/molokai" }) -- Color scheme

	use({ "nvim-lualine/lualine.nvim" }) -- Statusline
	use({ "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup {} end }) -- Autopairs, integrates with both cmp and treesitter
	use({ "kyazdani42/nvim-web-devicons" }) -- File icons
	use({ "akinsho/bufferline.nvim" })

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
    config = function()
      local cmp = require'cmp'
      local luasnip = require'luasnip'

      cmp.setup({
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<C-n>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(1)
            elseif cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, {"i", "s"}
          ),
          ['<C-p>'] = cmp.mapping(function(fallback)
            if luasnip.choice_active() then
              luasnip.change_choice(-1)
            elseif cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, {"i", "s"}
          ),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump(1)
            else
              fallback()
            end
          end, {"i", "s"}
          ),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, {"i", "s"}
          ),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
            { name = 'buffer' },
          }),
        snippet = {
          expand = function(args)
            if not luasnip then
              return
            end
            luasnip.lsp_expand(args.body)
          end
        }
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = 'buffer' },
          })
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline' }
          })
      })

    end,
  }) -- The completion plugin

	-- snippets
	use({ "L3MON4D3/LuaSnip",
    module = { "luasnip" },
    config = function()
      local ls = require("luasnip")
      require("luasnip.loaders.from_lua").load({paths = "./snippets"})

      ls.filetype_extend("vue", { "javascript" })
      ls.filetype_extend("typescript", { "javascript" })
      ls.filetype_extend("javascriptreact", { "javascript" })
      ls.filetype_extend("typescriptreact", { "javascriptreact" })
    end,
  }) --snippet engine

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
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
    config = function()
      local nvim_lsp = require('lspconfig')
      require('mason').setup()
      local mason_lspconfig = require('mason-lspconfig')
      mason_lspconfig.setup_handlers({ function(server_name)
        local opts = {}
        opts.on_attach = function(_, bufnr)
          local bufopts = { silent = true, buffer = bufnr, noremap = true }
          vim.keymap.set('n', 'gf', vim.lsp.buf.format, bufopts)
          vim.keymap.set('n', 'gh', ':Lspsaga hover_doc<CR>', bufopts)
          vim.keymap.set('n', 'gk', ':Lspsaga hover_doc ++keep<CR>', bufopts)
          vim.keymap.set('n', 'gd', ':Lspsaga lsp_finder<CR>', bufopts)
          vim.keymap.set('n', 'gp', ':Lspsaga peek_definition<CR>', bufopts)
          vim.keymap.set('n', '<Leader>ca', ':Lspsaga code_action<CR>', bufopts)
          vim.keymap.set('n', 'gn', ':Lspsaga rename<CR>', bufopts)
          vim.keymap.set('n', '[e', ':Lspsaga diagnostic_jump_prev<CR>', bufopts)
          vim.keymap.set('n', ']e', ':Lspsaga diagnostic_jump_next<CR>', bufopts)
        end
        nvim_lsp[server_name].setup(opts)
      end})
    end,
  }) -- simple to use language server installer
	use({ "williamboman/mason-lspconfig.nvim" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "glepnir/lspsaga.nvim", config = function() require("lspsaga").setup({})end, }) -- LSP UIs

	-- Formatter
	use({ "MunifTanjim/prettier.nvim" })

	-- Telescope
	use({ "nvim-telescope/telescope.nvim",
    module = { "telescope" },
    event = { "VimEnter" },
    requires = {
      { "nvim-telescope/telescope-file-browser.nvim", opt = true },
    },
    wants = {
      "telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.load_extension "file_browser"
      local opt = { silent=true, noremap=true }
      telescope.setup {
        defaults = {
          mappings = {
            n = {
              ["<C-c>"] = require('telescope.actions').close,
            }
          }
        }
      }
      vim.keymap.set("n", "<Leader>ff", ":Telescope find_files<CR>", opt)
      vim.keymap.set("n", "<Leader>gf", ":Telescope git_files<CR>", opt)
      vim.keymap.set("n", "<Leader>gs", ":Telescope git_status<CR>", opt)
      vim.keymap.set("n", "<Leader>gr", ":Telescope live_grep<CR>", opt)
      vim.keymap.set("n", "<Leader>fe", ":Telescope file_browser hidden=true initial_mode=normal<CR>", opt)
      vim.keymap.set("n", "<Leader>h", ":Telescope oldfiles<CR>", opt)
    end,
  })

  -- Treesitter
  use({ "nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" } })
  -- use({ "nvim-telescope/telescope-file-browser.nvim" })

  use({ "windwp/nvim-ts-autotag" })

  -- Filer
  use({ "lambdalisue/fern.vim" })

  -- Git
  use({ "lewis6991/gitsigns.nvim" })
  use({ "tpope/vim-fugitive" })

  -- easymotion
  use({ "phaazon/hop.nvim" })

  -- comment
  use({ "numToStr/Comment.nvim" })

  -- utility
  use({ "machakann/vim-sandwich" })
  use({ "akinsho/toggleterm.nvim" })
  use({ "skanehira/translate.vim" })
  use({ "junegunn/goyo.vim" })

  -- outline
  use({ "stevearc/aerial.nvim" })

  -- chatGpt
  use({ "shutils/ChatGPT.nvim",
    commit = "485eecb",
    event = { "VimEnter" },
    config = function()
      require("chatgpt").setup({
        keymaps = {
          submit = "<C-s>"
        }
      })
      vim.keymap.set("n", "tk", ":ChatGPT<CR>")
    end,
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })

  use({
  "folke/noice.nvim",
    config = function()
      require("noice").setup({
        -- add any options here
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
    })
  end,
  requires = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
    }
})

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

