local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = { noremap = true }
local helper = require("config.helper")

vim.cmd([[highlight PumUiSBar guifg=yellow]])

local function pum_set_option()
  local columns = vim.api.nvim_get_option("columns")
  local lines = vim.api.nvim_get_option("lines")
  vim.fn["pum#set_option"]({
    auto_confirm_time = 0,
    horizontal_menu = false,
    max_width = vim.fn.min({ math.floor(columns / 3), 50 }),
    max_height = math.floor(lines / 3),
    use_setline = false,
    border = "rounded",
    scrollbar_char = "┃",
    highlight_scrollbar = "PumUiSBar",
    preview = true,
    preview_border = "rounded",
    preview_height = math.floor(lines / 2),
    preview_width = math.floor(columns / 3),
  })
end

pum_set_option()

augroup("MyAutoCmd", { clear = true })
autocmd("VimResized", {
  group = "MyAutoCmd",
  pattern = "*",
  callback = pum_set_option,
})

local function ddc_global_setting()
  vim.fn["ddc#custom#patch_global"]({
    ui = "pum",
    cmdlineSources = {
      [":"] = { "skkeleton", "denippet", "cmdline", "cmdline-history", "file", "around" },
      ["@"] = { "skkeleton", "denippet", "cmdline-history", "input", "file", "around" },
      [">"] = { "skkeleton", "cmdline-history", "input", "file", "around" },
      ["/"] = { "skkeleton", "around" },
      ["?"] = { "skkeleton", "around" },
      ["-"] = { "skkeleton", "around" },
      ["="] = { "skkeleton", "input" },
    },
    sources = { "denippet", "lsp", "around", "dictionary", "cmdline", "skkeleton" },
    sourceOptions = {
      ["_"] = {
        matchers = { "matcher_fuzzy" },
        sorters = { "sorter_fuzzy" },
        converters = { "converter_fuzzy" },
        ignoreCase = true,
      },
      around = { mark = "[around]" },
      lsp = {
        mark = "[Lsp]",
      },
      cmdline = { mark = "[cmdline]" },
      file = {
        mark = "[file]",
        isVolatile = true,
        minAutoCompleteLength = 1000,
        forceCompletionPattern = "\\S/\\S*",
      },
      ["cmdline-history"] = {
        mark = "[history]",
        sorters = {},
      },
      skkeleton = {
        mark = "[skk]",
        matchers = { "skkeleton" },
        sorters = {},
        isVolatile = true,
      },
      dictionary = {
        mark = "[dict]",
      },
    },
    sourceParams = {
      lsp = {
        snippetEngine = vim.fn["denops#callback#register"](function(body)
          vim.fn["vsnip#anonymous"](body)
        end),
        enableResolveItem = true,
        enableAdditionalTextEdit = true,
        confirmBehavior = "replace",
      },
      dictionary = {
        paths = {
          vim.fn.stdpath("data") .. "/lazy/english-words/words.txt",
          vim.fn.expand("~/dotfiles/.config/dict/md-code-langs"),
        },
        firstCaseInsensitive = true,
      },
    },
    autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged", "CmdlineEnter" },
  })
end

ddc_global_setting()

local function ddc_filetype_setting()
  vim.fn["ddc#custom#patch_filetype"]({ "vim" }, {
    cmdlineSources = {
      [":"] = { "skkeleton", "cmdline", "file", "around" },
      ["@"] = { "skkeleton", "cmdline-history", "input", "file", "around" },
      [">"] = { "skkeleton", "cmdline-history", "input", "file", "around" },
      ["/"] = { "skkeleton", "around" },
      ["?"] = { "skkeleton", "around" },
      ["-"] = { "skkeleton", "around" },
      ["="] = { "skkeleton", "input" },
    },
  })
  vim.fn["ddc#custom#patch_filetype"]({ "markdown" }, {
    sources = { "obsidian_tag", "obsidian_link", "dictionary", "denippet", "lsp", "around", "cmdline", "skkeleton" },
    sourceOptions = {
      obsidian_tag = {
        mark = "[obsidian_tag]",
      },
      obsidian_link = {
        mark = "[obsidian_link]",
      },
    },
    sourceParams = {
      obsidian_tag = {
        vaults = helper.get_vaults(),
      },
      obsidian_link = {
        vaults = helper.get_vaults(),
      },
      dictionary = {
        paths = {
          vim.fn.expand("~/dotfiles/.config/dict/md-code-langs"),
        },
        firstCaseInsensitive = true,
      },
    },
  })
end

ddc_filetype_setting()

local function cmdline_post()
  if vim.b.prev_buffer_config ~= nil then
    vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  else
    vim.fn["ddc#custom#set_buffer"]({})
  end
end

function _G.ddc_cmdline_pre()
  vim.keymap.set("c", "<C-n>", function()
    vim.fn["pum#map#insert_relative"](1)
  end, opt)
  vim.keymap.set("c", "<C-p>", function()
    vim.fn["pum#map#insert_relative"](-1)
  end, opt)
  vim.keymap.set("c", "<C-y>", function()
    return vim.fn["denippet#expandable"]() and vim.fn["denippet#expand"]() or vim.fn["pum#map#confirm"]()
  end, { expr = true })
  vim.keymap.set("c", "<C-o>", function()
    vim.fn["pum#map#confirm_word"]()
  end, opt)
  vim.keymap.set("c", "<C-g>", function()
    vim.fn["pum#map#cancel"]()
  end, opt)
  vim.keymap.set("c", "<C-Space>", function()
    vim.fn["ddc#map#manual_complete"]()
  end, opt)

  if vim.b.prev_buffer_config == nil then
    vim.b.prev_buffer_config = vim.fn["ddc#custom#get_buffer"]()
  end

  autocmd("User", {
    group = "MyAutoCmd",
    pattern = "DDCCmdlineLeave",
    callback = cmdline_post,
    once = true,
  })

  vim.fn["ddc#enable_cmdline_completion"]()
end

vim.keymap.set("n", ":", "<Cmd>lua ddc_cmdline_pre()<CR>:", { noremap = true })

autocmd("CmdWinEnter", {
  group = "MyAutoCmd",
  callback = ddc_cmdline_pre,
})

local function ddc_keymap()
  vim.keymap.set("i", "<C-n>", function()
    if vim.fn["denippet#choosable"]() then
      vim.fn["denippet#choice"](1)
    else
      vim.fn["pum#map#insert_relative"](1)
    end
  end, opt)
  vim.keymap.set("i", "<C-p>", function()
    if vim.fn["denippet#choosable"]() then
      vim.fn["denippet#choice"](-1)
    else
      vim.fn["pum#map#insert_relative"](-1)
    end
  end, opt)
  vim.keymap.set("i", "<C-y>", function()
    vim.fn["pum#map#confirm"]()
  end, opt)
  vim.keymap.set("i", "<C-o>", function()
    vim.fn["pum#map#confirm_word"]()
  end, opt)
  vim.keymap.set("i", "<C-g>", function()
    vim.fn["pum#map#cancel"]()
  end, opt)
  vim.keymap.set("i", "<C-Space>", function()
    vim.fn["ddc#map#manual_complete"]()
  end, opt)
  vim.keymap.set({ "i", "s" }, "<Tab>", function()
    return vim.fn["denippet#jumpable"](1) and "<Plug>(denippet-jump-next)" or "<Tab>"
  end, { expr = true })
  vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
    return vim.fn["denippet#jumpable"](-1) and "<Plug>(denippet-jump-prev)" or "<S-Tab>"
  end, { expr = true })
end

ddc_keymap()
vim.fn["ddc#enable"]()
