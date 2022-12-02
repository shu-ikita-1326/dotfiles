local autocmd = vim.api.nvim_create_autocmd
if vim.env.zenhan then
  autocmd("InsertLeave", {
    pattern = "*",
    command = ":call system('${zenhan} 0')",
  })
end
