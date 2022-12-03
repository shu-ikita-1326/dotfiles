local autocmd = vim.api.nvim_create_autocmd
if vim.env.zenhan then
  autocmd("InsertLeave", {
    pattern = "*",
    command = ":call system('${zenhan} 0')",
  })
end

autocmd("TextYankPost", {
  pattern = "*",
  command = ":lua vim.highlight.on_yank {higroup='IncSearch', timeout=300, on_visual=true}"
})
