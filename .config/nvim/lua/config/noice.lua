local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

require("noice").setup({
  -- add any options here
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      -- ["cmp.entry.get_documentation"] = true,
    },
    signature = {
      enabled = true,
    },
    hover = {
      enabled = false,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
})

-- Temporarily turn off noise when using mason's search function
augroup("noiceDisable", { clear = true })
autocmd("FileType", {
  group = "noiceDisable",
  pattern = "mason",
  command = ":Noice disable",
})

augroup("noiceEnable", { clear = true })
autocmd("FileType", {
  group = "noiceEnable",
  pattern = "mason",
  callback = function()
    autocmd("BufLeave", {
      group = "noiceEnable",
      pattern = "*",
      command = ":Noice enable",
      once = true,
    })
  end,
  nested = true,
})

require("notify").setup({
  background_colour = "#000000",
  top_down = false,
})
