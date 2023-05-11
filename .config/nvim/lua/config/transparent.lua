local transparent = require("transparent")
transparent.setup({
  extra_groups = {
    "NeoTreeNormal"
  }
})

transparent.toggle(true)

-- Transparency setting of notify
require("notify").setup({
  background_colour = "#000000",
})

