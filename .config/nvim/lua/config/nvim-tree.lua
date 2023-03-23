local config = {
  view = {
    mappings = {
      custom_only = false,
      list = {
        { key = "l", action = "edit", action_cb = edit_or_open },
        { key = "L", action = "vsplit_preview", action_cb = vsplit_preview },
        { key = "h", action = "close_node" },
        { key = "H", action = "collapse_all", action_cb = collapse_all }
      }
    },
  },
  actions = {
    open_file = {
      quit_on_open = false
    }
  }
}

vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", { silent = true, noremap = true })
require('nvim-tree').setup(config)
