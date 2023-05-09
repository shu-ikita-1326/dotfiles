local augend = require("dial.augend")
require("dial.config").augends:register_group({
  default = {
    augend.integer.alias.decimal_int,
    augend.integer.alias.hex,
    augend.constant.alias.bool,
    augend.semver.alias.semver,
    augend.constant.alias.alpha,
    augend.constant.alias.Alpha,
    augend.date.alias["%Y/%m/%d"],
    augend.date.alias["%Y-%m-%d"],
    augend.date.alias["%m/%d"],
    augend.date.alias["%H:%M"],
    augend.date.alias["%H:%M:%S"],
  },
})
vim.keymap.set("n", "<C-n>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-p>", require("dial.map").dec_normal(), { noremap = true })
vim.keymap.set("v", "<C-n>", "<Plug>(dial-increment)gv", { noremap = true })
vim.keymap.set("v", "<C-p>", "<Plug>(dial-decrement)gv", { noremap = true })
