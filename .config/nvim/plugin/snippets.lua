local ls = require("luasnip")
require("luasnip.loaders.from_lua").load({paths = "./snippets"})

ls.filetype_extend("vue", { "javascript" })
