local M = {}

M.get_vaults = function()
  if vim.env.OBSIDIAN_VAULT_REMOTE == nil and vim.env.OBSIDIAN_VAULT_LOCAL == nil then
    return {}
  end
  local vaults = {}
  if vim.env.OBSIDIAN_VAULT_REMOTE ~= nil then
    table.insert(vaults, { path = vim.env.OBSIDIAN_VAULT_REMOTE, name = "remote" })
  end
  if vim.env.OBSIDIAN_VAULT_LOCAL ~= nil then
    table.insert(vaults, { path = vim.env.OBSIDIAN_VAULT_LOCAL, name = "local" })
  end
  return vaults
end

return M
