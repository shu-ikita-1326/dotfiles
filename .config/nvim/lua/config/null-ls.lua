local null_ls = require("null-ls")
require("mason-null-ls").setup({
  ensure_installed = {
    "jq",
    "markdownlint",
    "shellcheck",
    "jsonlint",
  },
  automatic_installation = false,
})

null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.diagnostics.markdownlint.with({
      extra_args = {
        "--config",
        "~/.config/markdownlint/option.json",
      }
    }),
    null_ls.builtins.formatting.markdownlint,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.diagnostics.jsonlint,
  },
})
