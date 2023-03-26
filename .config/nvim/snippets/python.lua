return {
  s(
    "def",
    fmta(
      [[
  def <>(<>):
  ]],
      {
        i(1, "myFunc"),
        i(2, "arg"),
      }
    )
  ),
  s(
    "ifmain",
    fmta(
      [[
  if __name__ == "__main__":
      main()<>
    ]],
      {
        i(0),
      }
    )
  ),
  s("froute", {
    t('@app.route("/'),
    i(1),
    t('", methods=["'),
    c(2, {
      t("GET"),
      t("POST"),
      t("PUT"),
      t("DELETE"),
    }),
    t('"])'),
    t({ "", "def " }),
    i(3, "myFunc"),
    t("("),
    i(4, "args"),
    t("):"),
    t({ "", "\t" }),
    i(5, "pass"),
    i(0),
  }),
}
