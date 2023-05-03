local neotree = require("neo-tree")
neotree.setup({
  close_if_last_window = true,
  window = {
    mappings = {
      ["l"] = { "open" },
      ["h"] = { "close_node" },
      ["i"] = { "node_info" },
      ["P"] = { "preview_img" },
      ["E"] = { "edit_drawio" },
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
    -- Display image. depends on feh.
    preview_img = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      local cmd = '!feh ' .. path
      vim.cmd(cmd)
    end,
    -- Edit drawio file. It depends on draio.
    edit_drawio = function(state)
      local node = state.tree:get_node()
      local path = node:get_id()
      local cmd = '!drawio ' .. path
      vim.cmd(cmd)
    end
  },
  source_selector = {
    winbar = true,
  },
})

vim.keymap.set("n", "<Leader>e", ":Neotree reveal=true<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>b", ":Neotree close<CR>", { silent = true, noremap = true })
