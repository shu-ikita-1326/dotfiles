local function fn(
  args
)
  return args[1]
end
return {
  s("PHONY", {
    t('PHONY: '),
    i(1, "target"),
    t({ "", "" }),
    f(fn,
      { 1 },
      {}
    ),
    t({ ":", "\t" }),
    i(2, "command"),
    i(0),
  }),
}
