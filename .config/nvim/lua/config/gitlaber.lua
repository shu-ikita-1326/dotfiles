local autocmd = vim.api.nvim_create_autocmd
local opt = { silent = true, noremap = true, buffer = true }

vim.g.gitlaber_config = {
  default_keymap_disable = true,
}
vim.keymap.set("n", "<Leader>gl", "<Cmd>Gitlaber<CR>", { silent = true, noremap = true })

function _G.gitlaber_project_status_keymap()
  vim.keymap.set("n", "i", "<Plug>(gitlaber-action-issue-list)", opt)
  vim.keymap.set("n", "m", "<Plug>(gitlaber-action-mr-list)", opt)
  vim.keymap.set("n", "b", "<Plug>(gitlaber-action-branch-list)", opt)
  vim.keymap.set("n", "w", "<Plug>(gitlaber-action-wiki-list)", opt)
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_issue_list_keymap()
  vim.keymap.set("n", "N", "<Plug>(gitlaber-action-issue-new)", opt)
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "P", "<Plug>(gitlaber-action-issue-preview)", opt)
  vim.keymap.set("n", "E", "<Plug>(gitlaber-action-issue-edit)", opt)
  vim.keymap.set("n", "a", "<Plug>(gitlaber-action-issue-assign)", opt)
  vim.keymap.set("n", "la", "<Plug>(gitlaber-action-issue-label)", opt)
  vim.keymap.set("n", "lr", "<Plug>(gitlaber-action-issue-unlabel)", opt)
  vim.keymap.set("n", "D", "<Plug>(gitlaber-action-issue-delete)", opt)
  vim.keymap.set("n", "C", "<Plug>(gitlaber-action-issue-close)", opt)
  vim.keymap.set("n", "O", "<Plug>(gitlaber-action-issue-reopen)", opt)
  vim.keymap.set("n", "B", "<Plug>(gitlaber-action-issue-browse)", opt)
  vim.keymap.set("n", "n", "<Plug>(gitlaber-action-issue-list-next)", opt)
  vim.keymap.set("n", "p", "<Plug>(gitlaber-action-issue-list-prev)", opt)
end

function _G.gitlaber_mr_list_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "A", "<Plug>(gitlaber-action-mr-approve)", opt)
  vim.keymap.set("n", "U", "<Plug>(gitlaber-action-mr-unapprove)", opt)
  vim.keymap.set("n", "aa", "<Plug>(gitlaber-action-mr-assign-assignee)", opt)
  vim.keymap.set("n", "ar", "<Plug>(gitlaber-action-mr-assign-reviewer)", opt)
  vim.keymap.set("n", "B", "<Plug>(gitlaber-action-mr-browse)", opt)
  vim.keymap.set("n", "C", "<Plug>(gitlaber-action-mr-close)", opt)
  vim.keymap.set("n", "O", "<Plug>(gitlaber-action-mr-reopen)", opt)
  vim.keymap.set("n", "D", "<Plug>(gitlaber-action-mr-delete)", opt)
  vim.keymap.set("n", "E", "<Plug>(gitlaber-action-mr-edit)", opt)
  vim.keymap.set("n", "la", "<Plug>(gitlaber-action-mr-label)", opt)
  vim.keymap.set("n", "lr", "<Plug>(gitlaber-action-mr-unlabel)", opt)
  vim.keymap.set("n", "M", "<Plug>(gitlaber-action-mr-merge)", opt)
  vim.keymap.set("n", "N", "<Plug>(gitlaber-action-mr-new)", opt)
  vim.keymap.set("n", "P", "<Plug>(gitlaber-action-mr-preview)", opt)
  vim.keymap.set("n", "n", "<Plug>(gitlaber-action-mr-list-next)", opt)
  vim.keymap.set("n", "p", "<Plug>(gitlaber-action-mr-list-prev)", opt)
  vim.keymap.set("n", "d", "<Plug>(gitlaber-action-mr-change-list)", opt)
end

function _G.gitlaber_mr_change_list_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "<CR>", "<Plug>(gitlaber-action-mr-change-diff)", opt)
end

function _G.gitlaber_diff_new_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_diff_old_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_branch_list_keymap()
  vim.keymap.set("n", "N", "<Plug>(gitlaber-action-branch-new)", opt)
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_wiki_list_keymap()
  vim.keymap.set("n", "N", "<Plug>(gitlaber-action-wiki-new)", opt)
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "B", "<Plug>(gitlaber-action-wiki-browse)", opt)
  vim.keymap.set("n", "D", "<Plug>(gitlaber-action-wiki-delete)", opt)
  vim.keymap.set("n", "E", "<Plug>(gitlaber-action-wiki-edit)", opt)
  vim.keymap.set("n", "P", "<Plug>(gitlaber-action-wiki-preview)", opt)
  vim.keymap.set("n", "n", "<Plug>(gitlaber-action-wiki-list-next)", opt)
  vim.keymap.set("n", "p", "<Plug>(gitlaber-action-wiki-list-prev)", opt)
end

function _G.gitlaber_issue_preview_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_issue_edit_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "<C-s>", "<Plug>(gitlaber-action-issue-edit-submit)", opt)
end

function _G.gitlaber_mr_preview_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_mr_edit_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "<C-s>", "<Plug>(gitlaber-action-mr-edit-submit)", opt)
end

function _G.gitlaber_wiki_preview_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

function _G.gitlaber_wiki_edit_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "<C-s>", "<Plug>(gitlaber-action-wiki-edit-submit)", opt)
end

function _G.gitlaber_ui_select_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
  vim.keymap.set("n", "<CR>", "<Plug>(gitlaber-action-ui-select)", opt)
end

function _G.gitlaber_mr_discussion_keymap()
  vim.keymap.set("n", "q", "<Plug>(gitlaber-action-buffer-close)", opt)
end

autocmd("FileType", {
  pattern = "*gitlaber-project-status*",
  command = "lua gitlaber_project_status_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-issue-list*",
  command = "lua gitlaber_issue_list_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-mr-list*",
  command = "lua gitlaber_mr_list_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-mr-change-list*",
  command = "lua gitlaber_mr_change_list_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-diff-new*",
  command = "lua gitlaber_diff_new_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-diff-old*",
  command = "lua gitlaber_diff_old_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-branch-list*",
  command = "lua gitlaber_branch_list_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-wiki-list*",
  command = "lua gitlaber_wiki_list_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-issue-preview*",
  command = "lua gitlaber_issue_preview_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-issue-edit*",
  command = "lua gitlaber_issue_edit_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-mr-preview*",
  command = "lua gitlaber_mr_preview_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-mr-edit*",
  command = "lua gitlaber_mr_edit_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-wiki-preview*",
  command = "lua gitlaber_wiki_preview_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-wiki-edit*",
  command = "lua gitlaber_wiki_edit_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-ui-select*",
  command = "lua gitlaber_ui_select_keymap()",
})

autocmd("FileType", {
  pattern = "*gitlaber-mr-discussion*",
  command = "lua gitlaber_mr_discussion_keymap()",
})
