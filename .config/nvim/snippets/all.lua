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
      extras.partial(os.date, "%Y-%m-%d"),
      extras.partial(os.date, "%Y-%m-%d %a"),
      extras.partial(os.date, "<%Y-%m-%d %a>"),
    }),
  }),
  s("now", {
    c(1, {
      extras.partial(os.date, "%Y-%m-%d %H:%M:%S"),
      extras.partial(os.date, "%Y-%m-%d %a %H:%M:%S"),
      extras.partial(os.date, "<%Y-%m-%d %a %H:%M:%S>"),
    }),
  }),
}
