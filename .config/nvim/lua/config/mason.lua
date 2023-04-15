local nvim_lsp = require("lspconfig")
require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "pylsp",
    "tsserver",
    "html",
    "gopls",
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

vim.keymap.set({ "n", "v" }, "gf", vim.lsp.buf.format, opt)
vim.keymap.set("n", "gh", ":Lspsaga hover_doc<CR>", opt)
vim.keymap.set("n", "gH", ":Lspsaga hover_doc ++keep<CR>", opt)
vim.keymap.set("n", "gd", ":Lspsaga lsp_finder<CR>", opt)
vim.keymap.set("n", "gp", ":Lspsaga peek_definition<CR>", opt)
vim.keymap.set({ "n", "v" }, "ga", ":Lspsaga code_action<CR>", opt)
vim.keymap.set("n", "gn", ":Lspsaga rename<CR>", opt)
vim.keymap.set("n", "[e", ":Lspsaga diagnostic_jump_prev<CR>", opt)
vim.keymap.set("n", "]e", ":Lspsaga diagnostic_jump_next<CR>", opt)
