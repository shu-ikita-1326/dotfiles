local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
require("mason").setup({
  ui = {
    border = "rounded",
  },
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  update_in_insert = false,
  virtual_text = {
    format = function(diagnostic)
      return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
    end,
  },
})

local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pylsp",
    "tsserver",
    "html",
    "gopls",
    "docker_compose_language_service",
    "dockerls",
    -- "denols",
    "efm",
    "jsonls",
  },
})

mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,
  ["efm"] = function()
    nvim_lsp.efm.setup({
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      },
      settings = {
        rootMarkers = {
          ".git/",
        },
        languages = {
          sh = {
            {
              lintCommand = "shellcheck -f gcc -x",
              lintSource = "shellcheck",
              lintFormats = {
                "%f:%l:%c: %trror: %m",
                "%f:%l:%c: %tarning: %m",
                "%f:%l:%c: %tote: %m",
              },
            },
          },
          markdown = {
            {
              lintCommand = "markdownlint -s -c ~/.config/markdownlint/option.json",
              lintStdin = true,
              lintFormats = {
                "%f:%l %m",
              },
              formatCommand = "prettier",
            },
          },
          vim = {
            {
              lintCommand = "vint -",
              lintStdin = true,
              lintFormats = {
                "%f:%l:%c: %m",
              },
            },
          },
          lua = {
            {
              formatStdin = true,
              formatCommand = "stylua --color Never -",
            },
          },
        },
      },
      filetypes = {
        "sh",
        "markdown",
        "vim",
        "lua",
      },
    })
  end,
  ["pylsp"] = function()
    nvim_lsp.pylsp.setup({
      root_dir = function(fname)
        return util.root_pattern(".git")(fname) or vim.fn.getcwd()
      end,
      settings = {
        pylsp = {
          plugins = {
            flake8 = {
              enabled = true,
            },
            mccabe = {
              enabled = false,
            },
            pyflakes = {
              enabled = false,
            },
            pycodestyle = {
              enabled = false,
              maxLineLength = 120,
            },
          },
        },
      },
    })
  end,
  ["lua_ls"] = function()
    nvim_lsp.lua_ls.setup({
      root_dir = function(fname)
        return util.root_pattern(".git")(fname) or vim.fn.getcwd()
      end,
      settings = {
        Lua = {
          format = {
            enable = false,
          },
        },
      },
    })
  end,
  -- NOTE: Starts with file type because it does not work with file name specification
  ["docker_compose_language_service"] = function()
    nvim_lsp.docker_compose_language_service.setup({
      filetypes = {
        "yaml",
      },
    })
  end,
})

local opt = { silent = true, noremap = true }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  -- Use a sharp border with `FloatBorder` highlights
  border = "rounded",
  -- add the title in hover float window
  title = "hover",
})

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format, opt)
vim.keymap.set("n", "gh", vim.lsp.buf.hover, opt)
vim.keymap.set("n", "gn", vim.lsp.buf.rename, opt)

vim.keymap.set("n", "<Leader>le", vim.diagnostic.open_float, opt)
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, opt)
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, opt)

-- Install packages other than lsp
local ensure_package = {
  "flake8",
  "vint",
  "shellcheck",
  "jq",
  "jsonlint",
  "prettier",
  "markdownlint",
  "stylua",
}

local installed_packages = require("mason-registry").get_installed_package_names()

for _, package in ipairs(ensure_package) do
  local package_installed = false

  for _, installed_package in ipairs(installed_packages) do
    if installed_package == package then
      package_installed = true
      break
    end
  end

  if not package_installed then
    vim.cmd("MasonInstall " .. package)
  end
end
