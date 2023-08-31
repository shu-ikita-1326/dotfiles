return {
  s("cp", {
    t("export const "),
    i(1, "myComponent"),
    t({ " = () => {", "\treturn (", "\t\t" }),
    i(2),
    i(0),
    t({ "", "\t)", "}" }),
  }),
  s("class", {
    t('className="'),
    i(1),
    t('"'),
    i(0),
  }),
}
