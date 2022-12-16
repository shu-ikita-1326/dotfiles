return {
  s("bang", {
    c(1, {
      t("#!/usr/bin/bash"),
      t("#!/usr/bin/sh"),
      t("#!/usr/bin/zsh"),
    })
  }
  ),
  s("today", {
    extras.partial(os.date, "%Y/%m/%d")
  })
}
