require("chatgpt").setup({
  keymaps = {
    submit = "<C-s>"
  }
})
vim.keymap.set("n", "tk", ":ChatGPT<CR>")
