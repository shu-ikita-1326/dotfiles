local ts = require("nvim-treesitter.configs")

ts.setup({
  ensure_installed = {
    "python",
    "lua",
    "rust",
    "javascript",
    "typescript",
    "dockerfile",
    "go",
    "html",
    "markdown",
    "markdown_inline",
    "yaml",
    "vim",
    "regex",
    "bash",
    "org",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
})

local paser_config = require("nvim-treesitter.parsers").get_parser_configs()
paser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
