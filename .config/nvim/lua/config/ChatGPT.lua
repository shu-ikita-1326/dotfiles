require("chatgpt").setup({
  popup_input = {
    submit = "<C-s>",
  }
})
vim.keymap.set("n", "tk", ":ChatGPT<CR>")
vim.cmd("highlight ChatGPTQuestion cterm=NONE gui=NONE")
