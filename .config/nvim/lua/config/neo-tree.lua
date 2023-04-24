local neotree = require("neo-tree")
neotree.setup({
  window = {
    mappings = {
      ["l"] = { "open" },
      ["h"] = { "close_node" },
      ["i"] = { "node_info" },
    }
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
    }
  },
  commands = {
    node_info = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      print(vim.fn.getfsize(path))
    end
  },
  source_selector = {
    winbar = true,
  }
})

vim.keymap.set("n", "<Leader>e", ":Neotree reveal=true<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>b", ":Neotree close<CR>", { silent = true, noremap = true })
