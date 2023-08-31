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
  s(
    '""""""',
    fmta(
      [[
"""関数の説明タイトル

関数についての説明文

Args:
    引数の名前 (引数の型): 引数の説明
    引数の名前 (:obj:`引数の型`, optional): 引数の説明.

Returns:
    戻り値の型: 戻り値の説明 (例 : True なら成功, False なら失敗.)

Raises:
    例外の名前: 例外の説明 (例 : 引数が指定されていない場合に発生 )

Yields:
    戻り値の型: 戻り値についての説明

Examples:

    関数の使い方について記載

Note:
    注意事項などを記載

"""<>
  ]],
      {
        i(1, ""),
      }
    )
  ),
}
