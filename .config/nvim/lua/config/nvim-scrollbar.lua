require("scrollbar").setup({
  marks = {
    Cursor = {
      text = "■",
    },
  },
  handlers = {
    gitsigns = true,
  },
  excluded_filetypes = {
    "neo-tree",
    "sagacodeaction",
  },
})
