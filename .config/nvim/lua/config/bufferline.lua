local bufferline = require('bufferline')
bufferline.setup({
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true -- use a "true" to enable the default, or set your own character
      }
    },
    separator_style = "slant",
    buffer_close_icon = '',
  }
})
