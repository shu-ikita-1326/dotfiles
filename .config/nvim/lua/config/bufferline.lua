local bufferline = require('bufferline')
bufferline.setup({
  options = {
    offsets = {
      {
        filetype = "neo-tree",
        text = "Explorer",
        highlight = "Directory",
        separator = true -- use a "true" to enable the default, or set your own character
      }
    },
    separator_style = "slant",
    buffer_close_icon = '',
    custom_filter = function(buf_number, buf_numbers)
        -- filter out by buffer name
        if vim.fn.bufname(buf_number) ~= "" then
            return true
        end
    end,
  }
})
