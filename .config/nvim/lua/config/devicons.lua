require('nvim-web-devicons').setup({
  strict = true,
  override_by_filename = {
    ["docker-compose.yml"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Dockerfile",
    },
    ["docker-compose.yaml"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Dockerfile",
    },
    [".dockerignore"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Dockerfile",
    },
    ["dockerfile"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Dockerfile",
    },
  },
  override_by_extension = {
    ["svg"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Svg",
    },
    ["log"] = {
      icon = "",
      color = "#458ee6",
      cterm_color = "68",
      name = "Log",
    },
    ["txt"] = {
      icon = "",
      color = "#447028",
      cterm_color = "22",
      name = "Txt",
    },
  }
})
