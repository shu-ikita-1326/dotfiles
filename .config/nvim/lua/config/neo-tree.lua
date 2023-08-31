local neotree = require("neo-tree")
neotree.setup({
  close_if_last_window = true,
  window = {
    mappings = {
      ["l"] = { "open" },
      ["h"] = { "close_node" },
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
    sources = {                    -- table
      {
        source = "filesystem",     -- string
        display_name = "  Files " -- string | nil
      },
      {
        source = "buffers",          -- string
        display_name = "  Buffers " -- string | nil
      },
      {
        source = "git_status",   -- string
        display_name = " 󰊢 Git " -- string | nil
      },
    },
  },
  default_component_configs = {
    git_status = {
      symbols = {
        -- Change type
        added     = "✚", -- NOTE: you can set any of these to an empty string to not show them
        deleted   = "✖",
        modified  = "",
        renamed   = "",
        -- Status type
        untracked = "",
        ignored   = "",
        unstaged  = "",
        staged    = "",
        conflict  = "",
      },
      align = "right",
    },
  },
})

vim.keymap.set("n", "<Leader>e", ":Neotree reveal=true<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>E", ":Neotree toggle<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<Leader>b", ":Neotree close<CR>", { silent = true, noremap = true })
