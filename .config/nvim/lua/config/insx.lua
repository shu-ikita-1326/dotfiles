require("insx.preset.standard").setup()
local esc = require("insx").helper.regex.esc
require("insx").add(
  "<C-h>",
  require("insx.recipe.delete_pair")({
    open_pat = esc("("),
    close_pat = esc(")"),
  })
)
require("insx").add(
  "<C-h>",
  require("insx.recipe.delete_pair")({
    open_pat = esc("{"),
    close_pat = esc("}"),
  })
)
require("insx").add(
  "<C-h>",
  require("insx.recipe.delete_pair")({
    open_pat = esc("["),
    close_pat = esc("]"),
  })
)
require("insx").add(
  "<C-h>",
  require("insx.recipe.delete_pair")({
    open_pat = esc("'"),
    close_pat = esc("'"),
  })
)
require("insx").add(
  "<C-h>",
  require("insx.recipe.delete_pair")({
    open_pat = esc('"'),
    close_pat = esc('"'),
  })
)
