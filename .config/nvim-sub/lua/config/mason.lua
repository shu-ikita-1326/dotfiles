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
  },
})
mason_lspconfig.setup_handlers({
  function(server_name)
    local opts = {}
    opts.on_attach = function(_, bufnr)
      local bufopts = { silent = true, buffer = bufnr, noremap = true }
    end
    nvim_lsp[server_name].setup(opts)
  end,
})

local opt = { silent = true, noremap = true }

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = "single",
    -- add the title in hover float window
    title = "hover"
  }
)

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format, opt)
vim.keymap.set("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opt)
vim.keymap.set("n", "gn", ":lua vim.lsp.buf.rename()<CR>", opt)
