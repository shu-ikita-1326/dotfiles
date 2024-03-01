local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("ObsidianOpen", { clear = true })
autocmd("FileType", {
  group ="ObsidianOpen",
  pattern = "markdown",
  command = "ObsidianOpen",
})
