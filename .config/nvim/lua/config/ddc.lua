local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local opt = { noremap = true }

vim.cmd([[highlight PumUiSBar guifg=yellow]])

local function pum_set_option()
  local columns = vim.api.nvim_get_option('columns')
  local lines = vim.api.nvim_get_option('lines')
  vim.fn["pum#set_option"]({
    auto_confirm_time = 0,
    horizontal_menu = false,
    max_width = vim.fn.min({ math.floor(columns / 3), 50 }),
    max_height = math.floor(lines / 3),
    use_setline = false,
    border = 'rounded',
    scrollbar_char = '┃',
    highlight_scrollbar = 'PumUiSBar',
    preview = true,
    preview_border = 'rounded',
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
    ui = 'pum',
    cmdlineSources = {
      [':'] = { 'skkeleton', 'cmdline', 'cmdline-history', 'file', 'around' },
      ['@'] = { 'skkeleton', 'cmdline-history', 'input', 'file', 'around' },
      ['>'] = { 'skkeleton', 'cmdline-history', 'input', 'file', 'around' },
      ['/'] = { 'skkeleton', 'around' },
      ['?'] = { 'skkeleton', 'around' },
      ['-'] = { 'skkeleton', 'around' },
      ['='] = { 'skkeleton', 'input' },
    },
    sources = { 'vsnip', 'nvim-lsp', 'around', 'cmdline', 'skkeleton' },
    sourceOptions = {
      ['_'] = {
        matchers = { 'matcher_fuzzy' },
        sorters = { 'sorter_fuzzy' },
        converters = { 'converter_fuzzy' },
        ignoreCase = true,
      },
      around = { mark = '[around]' },
      ['nvim-lsp'] = {
        mark = '[Lsp]',
      },
      cmdline = { mark = '[cmdline]' },
      vsnip = { mark = '[vsnip]' },
      file = {
        mark = '[file]',
        isVolatile = true,
        minAutoCompleteLength = 1000,
        forceCompletionPattern = '\\S/\\S*',
      },
      ['cmdline-history'] = {
        mark = '[history]',
        sorters = {},
      },
      skkeleton = {
        mark = '[skk]',
        matchers = { 'skkeleton' },
        sorters = {},
        isVolatile = true,
      },
    },
    sourceParams = {
      ['nvim-lsp'] = {
        snippetEngine = vim.fn["denops#callback#register"](function(body)
          vim.fn["vsnip#anonymous"](body)
        end
        ),
        enableResolveItem = true,
        enableAdditionalTextEdit = true,
        confirmBehavior = 'replace',
      },
    },
    autoCompleteEvents = { 'InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged', 'CmdlineEnter' },
  })
end

ddc_global_setting()

local function ddc_filetype_setting()
  vim.fn["ddc#custom#patch_filetype"](
    { "vim" },
    {
      cmdlineSources = {
        [':'] = { 'skkeleton', 'cmdline', 'file', 'around' },
        ['@'] = { 'skkeleton', 'cmdline-history', 'input', 'file', 'around' },
        ['>'] = { 'skkeleton', 'cmdline-history', 'input', 'file', 'around' },
        ['/'] = { 'skkeleton', 'around' },
        ['?'] = { 'skkeleton', 'around' },
        ['-'] = { 'skkeleton', 'around' },
        ['='] = { 'skkeleton', 'input' },
      },
    }
  )
end

ddc_filetype_setting()

local function cmdline_post()
  vim.keymap.del("c", "<C-n>", opt)
  vim.keymap.del("c", "<C-p>", opt)
  vim.keymap.del("c", "<C-y>", opt)
  vim.keymap.del("c", "<C-e>", opt)
  vim.keymap.del("c", "<C-Space>", opt)

  if vim.b.prev_buffer_config ~= nil then
    vim.fn["ddc#custom#set_buffer"](vim.b.prev_buffer_config)
    vim.b.prev_buffer_config = nil
  else
    vim.fn["ddc#custom#set_buffer"]({})
  end
end

local function cmdline_pre()
  vim.keymap.set("c", "<C-n>", function()
    vim.fn["pum#map#insert_relative"](1)
  end, opt)
  vim.keymap.set("c", "<C-p>", function()
    vim.fn["pum#map#insert_relative"](-1)
  end, opt)
  vim.keymap.set("c", "<C-y>", function()
    vim.fn["pum#map#confirm"]()
  end, opt)
  vim.keymap.set("c", "<C-o>", function()
    vim.fn["pum#map#confirm_word"]()
  end, opt)
  vim.keymap.set("c", "<C-e>", function()
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

autocmd("CmdlineEnter", {
  group = "MyAutoCmd",
  pattern = "*",
  callback = cmdline_pre,
})

local function ddc_keymap()
  vim.keymap.set("i", "<C-n>", function()
    vim.fn["pum#map#insert_relative"](1)
  end, opt)
  vim.keymap.set("i", "<C-p>", function()
    vim.fn["pum#map#insert_relative"](-1)
  end, opt)
  vim.keymap.set("i", "<C-y>", function()
    vim.fn["pum#map#confirm"]()
  end, opt)
  vim.keymap.set("i", "<C-o>", function()
    vim.fn["pum#map#confirm_word"]()
  end, opt)
  vim.keymap.set("i", "<C-e>", function()
    vim.fn["pum#map#cancel"]()
  end, opt)
  vim.keymap.set("i", "<C-Space>", function()
    vim.fn["ddc#map#manual_complete"]()
  end, opt)
end

ddc_keymap()
vim.fn["ddc#enable"]()
