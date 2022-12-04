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

-- Todo: osによって動作を切り替える
autocmd("TextYankPost", {
  pattern = "*",
  command = ":call system('clip.exe', @0)"
})

autocmd("QuickfixCmdPost", {
  pattern = "*",
  command = "cwindow"
})
