return {
  s("def",
  fmta(
  [[
  def <>(<>):
  ]],
  {
    i(1, "myFunc"),
    i(2, "arg")
  }
  )
  ),
  s("ifmain",
  fmta(
  [[
  if __name__ == "__main__":
      main()<>
    ]],
    {
      i(0)
    }
    )
    )
  }
