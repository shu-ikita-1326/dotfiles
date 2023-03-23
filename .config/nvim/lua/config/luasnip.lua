local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({ paths = "./snippets" })

ls.filetype_extend("vue", { "javascript" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescriptreact", { "javascriptreact" })
