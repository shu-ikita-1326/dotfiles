local autocmd = vim.api.nvim_create_autocmd
local base_layout = {
  popup_input = {
    submit = "<C-s>",
  },
  actions_paths = {
    "~/.config/ChatGPT/actions.json",
  },
  edit_with_instructions = {
    diff = false,
    keymaps = {
      close = "<C-c>",
      accept = "<C-y>",
      toggle_diff = "<C-d>",
      toggle_settings = "<C-o>",
      cycle_windows = "<Tab>",
      use_output_as_input = "<C-t>",
    },
  },
}
local from_shell_layout = {
  popup_layout = {
    center = {
      width = "100%",
      height = "100%",
    },
  },
}

if pcall(function()
  return vim.api.nvim_get_var("from_shell")
end) then
  for k, v in pairs(from_shell_layout) do
    base_layout[k] = v
  end

  autocmd("User", {
    pattern = "ChatGPTClose",
    command = "qall",
  })
end

require("chatgpt").setup(base_layout)

local opt = { silent = true, noremap = true }
vim.keymap.set("n", "tk", ":ChatGPT<CR>", opt)
