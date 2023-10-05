vim.fn["skkeleton#config"]({
  eggLikeNewline = true,
  registerConvertResult = true,
  globalDictionaries = { vim.fn.stdpath("data") .. "/lazy/dict/SKK-JISYO.L" },
})

-- NOTE: I tried writing it using lua notation, but it didn't work.
vim.cmd([[call add(g:skkeleton#mapped_keys, '<C-l>')]])
vim.cmd([[call skkeleton#register_keymap('input', "<C-l>", 'katakana')]])

vim.keymap.set({ "i", "c", "t" }, "<C-k>", "<Plug>(skkeleton-toggle)")
