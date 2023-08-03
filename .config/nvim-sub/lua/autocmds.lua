local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
if vim.env.zenhan then
  autocmd("InsertLeave", {
    pattern = "*",
    command = ":call system('${zenhan} 0')",
  })
end

autocmd("TextYankPost", {
  pattern = "*",
  command = ":lua vim.highlight.on_yank {higroup='IncSearch', timeout=300, on_visual=true}",
})

autocmd("QuickfixCmdPost", {
  pattern = "*",
  command = "cwindow",
})

-- dduとの相性により無効化中
-- autocmd("WinEnter", {
--   pattern = "*",
--   command = "set cursorline",
-- })
--
-- autocmd("WinLeave", {
--   pattern = "*",
--   command = "set nocursorline",
-- })

autocmd("TermOpen", {
  pattern = "term://*",
  command = "startinsert | set nonumber",
})

autocmd("WinEnter", {
  pattern = "term://*",
  command = "startinsert",
})

augroup("YankSetup", { clear = true })
autocmd("VimEnter", {
  group = "YankSetup",
  pattern = "*",
  callback = function()
    -- Use win32yank.exe for yank if the execution environment is wsl
    if vim.fn.executable('wslpath') == 1 then
      if vim.fn.executable('win32yank.exe') == 1 then
        vim.api.nvim_command('set clipboard+=unnamedplus')
        vim.g.clipboard = {
          name = 'myClipboard',
          copy = {
            ['+'] = 'win32yank.exe -i',
            ['*'] = 'win32yank.exe -i',
          },
          paste = {
            ['+'] = 'win32yank.exe -o',
            ['*'] = 'win32yank.exe -o',
          },
        }
      else
        vim.notify("Install win32yank.exe if you want to share yanked code to the Windows clipboard. win32yank HP:(https://github.com/equalsraf/win32yank)",
        vim.log.levels.INFO)
      end
    end
  end,
})

