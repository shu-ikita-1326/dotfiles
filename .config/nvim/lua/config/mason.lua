local nvim_lsp = require("lspconfig")
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup_handlers({
  function(server_name)
    local opts = {}
    opts.on_attach = function(_, bufnr)
      local bufopts = { silent = true, buffer = bufnr, noremap = true }
    end
    nvim_lsp[server_name].setup(opts)
  end,
})

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format)
vim.keymap.set("n", "gh", ":Lspsaga hover_doc<CR>")
vim.keymap.set("n", "gH", ":Lspsaga hover_doc ++keep<CR>")
vim.keymap.set("n", "gd", ":Lspsaga lsp_finder<CR>")
vim.keymap.set("n", "gp", ":Lspsaga peek_definition<CR>")
vim.keymap.set("n", "ga", ":Lspsaga code_action<CR>")
vim.keymap.set("n", "gn", ":Lspsaga rename<CR>")
vim.keymap.set("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "]e", ":Lspsaga diagnostic_jump_next<CR>")
