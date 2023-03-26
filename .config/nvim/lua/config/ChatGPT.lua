require("chatgpt").setup({
  keymaps = {
    submit = "<C-s>",
  },
  chat_window = {
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      wrap = true,
    },
  },
})
vim.keymap.set("n", "tk", ":ChatGPT<CR>")
