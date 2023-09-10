local nvim_lsp = require("lspconfig")
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
          }
        }
      },
      filetypes = {
        "sh",
      }
    })
  end
})

local opt = { silent = true, noremap = true }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "rounded",
    -- add the title in hover float window
    title = "hover"
  }
)

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format, opt)
vim.keymap.set("n", "gh", vim.lsp.buf.hover, opt)
vim.keymap.set("n", "gn", vim.lsp.buf.rename, opt)
