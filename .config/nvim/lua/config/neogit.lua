local neogit = require("neogit")
neogit.setup({
  integrations = {
    diffview = true
  }
})

vim.keymap.set("n", "<Leader>gg", ":Neogit<CR>", { silent = true, noremap = true })
