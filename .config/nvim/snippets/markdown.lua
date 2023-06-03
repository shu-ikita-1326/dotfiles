return {
  s("summary", {
    t("<details><summary>"),
    i(1, "title"),
    t({ "</summary><div>", "", "```" }),
    i(2, "lang"),
    t({ "", "" }),
    i(0, "code"),
    t({ "", "```", "</div></details>"}),
  }),
}
