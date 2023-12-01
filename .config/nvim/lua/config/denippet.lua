local function snippet_loader(glab_str)
  local paths = vim.fn.glob(glab_str)
  if paths == "" then
    print("Snippet file is not found.")
  end
  for p in paths:gmatch("[^\n]+") do
    local lang = vim.fn.fnamemodify(p, ":h:t")
    if lang == "global" then
      lang = '*'
    end
    vim.fn["denippet#load"](p, lang)
  end
end

snippet_loader(vim.env.CONF_DIR .. "/denippet/**/*.*")
