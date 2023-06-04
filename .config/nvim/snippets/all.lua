return {
  s("bang", {
    c(1, {
      t("#!/usr/bin/bash"),
      t("#!/usr/bin/sh"),
      t("#!/usr/bin/zsh"),
    }),
  }),
  s("today", {
    c(1, {
      t(os.date("%Y-%m-%d")),
      t(os.date("%Y-%m-%d %a")),
      t(os.date("<%Y-%m-%d %a>")),
    }),
  }),
  s("now", {
    c(1, {
      t(os.date("%Y-%m-%d %H:%M:%S")),
      t(os.date("%Y-%m-%d %a %H:%M:%S")),
      t(os.date("<%Y-%m-%d %a %H:%M:%S>")),
    }),
  }),
}
