local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

augroup("OpenObsidian", { clear = true })
autocmd("FileType", {
  group ="OpenObsidian",
  pattern = "markdown",
  command = "OpenObsidian",
})
