return {
  s("fn", {
    c(1, {
      sn(nil, {
        i(1),
        c(2, {
          t("const"),
          t("let"),
          t("var"),
        }),
        t(" "),
        i(3, "myFunc"),
        t(" = ("),
        i(4, "args"),
        t(") => {"),
        t({ "", " " }),
        i(5),
        t({ "", "}" }),
        i(0),
      }),
      sn(nil, {
        i(1),
        c(2, {
          t("const"),
          t("let"),
          t("var"),
        }),
        t(" "),
        i(3, "myFunc"),
        t(" = function("),
        i(4, "args"),
        t(") {"),
        t({ "", " " }),
        i(5),
        t({ "", "}" }),
        i(0),
      }),
    }),
  }),
}
