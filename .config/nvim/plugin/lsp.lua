local nvim_lsp = require('lspconfig')
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup_handlers({ function(server_name)
  local opts = {}
  opts.on_attach = function(_, bufnr)
    local bufopts = { silent = ture, buffer = bufnr }
    vim.keymap.set('n', 'gf', vim.lsp.buf.format, bufopts)
    vim.keymap.set('n', 'gh', ':Lspsaga hover_doc<CR>', bufopts)
    vim.keymap.set('n', 'gd', ':Lspsaga lsp_finder<CR>', bufopts)
    vim.keymap.set('n', 'gp', ':Lspsaga peek_definition<CR>', bufopts)
  end
  nvim_lsp[server_name].setup(opts)
end})
