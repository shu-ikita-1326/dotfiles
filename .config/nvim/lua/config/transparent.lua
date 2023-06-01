local transparent = require("transparent")
transparent.setup({
  extra_groups = {
    "NeoTreeNormal",
    "LspTroubleNormal",
    "TroubleNormal",
    "Normal",
    "NormalFloat",
  }
})

transparent.toggle(true)

-- Transparency setting of notify
require("notify").setup({
  background_colour = "#000000",
})

