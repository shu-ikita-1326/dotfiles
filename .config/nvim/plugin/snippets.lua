vim.keymap.set("i", "<Tab>", "<Plug>luasnip-jump-next")
vim.keymap.set("i", "<S-Tab>", "<Plug>luasnip-jump-prev")

require("luasnip.loaders.from_lua").load({paths = "./snippets"})
