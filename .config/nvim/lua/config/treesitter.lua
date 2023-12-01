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
    "http",
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
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["as"] = "@scope",
      },
      selection_modes = {
        ["@parameter.outer"] = "v",
        ["@function.outer"] = "V",
        ["@class.outer"] = "<c-v>",
      },
      include_surrounding_whitespace = true,
    },
  },
})

local paser_config = require("nvim-treesitter.parsers").get_parser_configs()
paser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
