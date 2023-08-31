return {
  s("version", {
    t('version: "'),
    i(1, "3"),
    t('"'),
  }),
  s("services", {
    t("services:"),
  }),
  s("build", {
    t({ "build:", "\tcontext: " }),
    i(1, "./ctx"),
    t({ "", "\tdockerfile: " }),
    i(2, "Dockerfile"),
  }),
  s("ports", {
    t({ "ports:", "\t- " }),
    i(1, "4000"),
    t(":"),
    i(2, "4000"),
  }),
  s("condition", {
    t({ "condition: " }),
    c(1, {
      t("service_healthy"),
      t("service_started"),
      t("service_completed_successfully"),
    })
  }),
  s("depends_on", {
    t({ "depends_on:", "\t" }),
    c(1, {
      sn(nil, {
        t("- "),
        i(1, "service_name")
      }),
      sn(nil, {
        i(1, "service_name"),
        t({ ":", "\t\tcondition: " }),
        c(2, {
          t("service_healthy"),
          t("service_started"),
          t("service_completed_successfully"),
        })
      })
    })
  })
}
