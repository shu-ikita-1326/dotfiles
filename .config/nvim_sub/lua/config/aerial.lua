require("aerial").setup({
  layout = {
    default_direction = "prefer_left",
  },
  manage_folds = true,
  nerd_font = false,
  icons = {
    Array         = " ",
    Boolean       = " ",
    Class         = " ",
    Constant      = " ",
    Constructor   = " ",
    Enum          = " ",
    EnumMember    = " ",
    Event         = " ",
    Field         = " ",
    File          = " ",
    Function      = "[F]",
    Interface     = " ",
    Key           = " ",
    Method        = " ",
    Module        = " ",
    Namespace     = " ",
    Null          = "[Nu]",
    Number        = " ",
    Object        = " ",
    Operator      = " ",
    Package       = " ",
    Property      = " ",
    String        = " ",
    Struct        = " ",
    TypeParameter = "[T]",
    Variable      = " ",
    Collapsed     = " ",
  },
})
local opt = { silent = true, noremap = true }

vim.keymap.set("n", "<Leader>a", ":AerialToggle<CR>", opt)
