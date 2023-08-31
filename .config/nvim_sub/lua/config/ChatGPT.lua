local autocmd = vim.api.nvim_create_autocmd
local base_layout = {
  popup_input = {
    submit = "<C-s>",
  }
}
local from_shell_layout = {
  popup_layout = {
    center = {
      width = "100%",
      height = "100%",
    },
  }
}

if pcall(function() return vim.api.nvim_get_var('from_shell') end) then
  for k, v in pairs(from_shell_layout) do
    base_layout[k] = v
  end

  autocmd("User", {
    pattern = "ChatGPTClose",
    command = "qall",
  })
end

require("chatgpt").setup(base_layout)
vim.keymap.set("n", "tk", ":ChatGPT<CR>")
