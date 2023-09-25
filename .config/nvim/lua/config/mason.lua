local nvim_lsp = require("lspconfig")
local util = require("lspconfig.util")
require("mason").setup({
  ui = {
    border = "rounded"
  }
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
    "denols",
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
              }
            }
          },
          markdown = {
            {
              lintCommand = "markdownlint -s -c ~/.config/markdownlint/option.json",
              lintStdin = true,
              lintFormats = {
                "%f:%l %m",
              }
            }
          },
          vim = {
            {
              lintCommand = "vint -",
              lintStdin = true,
              lintFormats = {
                "%f:%l:%c: %m",
              }
            }
          },
        }
      },
      filetypes = {
        "sh",
        "markdown",
        "vim",
      }
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
              enabled = true
            },
            pycodestyle = {
              enabled = false,
              maxLineLength = 120
            }
          }
        }
      }
    })
  end,
  -- NOTE: Starts with file type because it does not work with file name specification
  ["docker_compose_language_service"] = function()
    nvim_lsp.docker_compose_language_service.setup({
      filetypes = {
        "yaml",
      }
    })
  end
})

local opt = { silent = true, noremap = true }

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format, opt)
vim.keymap.set("n", "gh", vim.lsp.buf.hover, opt)
vim.keymap.set("n", "gn", vim.lsp.buf.rename, opt)

-- Install packages other than lsp
local ensure_package = {
  'flake8',
  'vint',
  'shellcheck',
  'jq',
  'jsonlint',
  'prettier',
  'markdownlint',
}

local installed_packages = require('mason-registry').get_installed_package_names()

for _, package in ipairs(ensure_package) do
  local package_installed = false

  for _, installed_package in ipairs(installed_packages) do
    if installed_package == package then
      package_installed = true
      break
    end
  end

  if not package_installed then
    vim.cmd('MasonInstall ' .. package)
  end
end
