local ls = require("luasnip")
return {
  -- A snippet that expands the trigger "hi" into the string "Hello, world!".
  s(
    { trig = "match" },
    {
      t("match ")
      , i(1)
    , t(" with")
    , t({ "", "| " })
    , i(2)
    , t(" => ")
    , i(3)
    , t({ "", "end" })
    }
  ),
  s(
    { trig = "let" },
    {
      t({ "let", "  " })
      , i(1)
    , t({ "  :=", "    " })
    , i(2)
    , t({ "", "in", "" })
    , i(3)
    }
  ),
  s(
    { trig = "def" },
    {
      t("Definition ")
      , i(1)
    , t({ "", "  (" })
    , i(2)
    , t({ ")", "  :" })
    , i(3)
    , t({ "", "  :=", "  " })
    , i(4)
    , t(".")
    }
  ),
  s(
    { trig = "fix" },
    {
      t("Fixpoint ")
      , i(1)
    , t({ "", "  (" })
    , i(2)
    , t({ ")", "  :" })
    , i(3)
    , t({ "", "  :=", "  " })
    , i(4)
    , t(".")
    }
  ),
  s(
    { trig = "lema" },
    {
      t("Lemma ")
      , i(1)
    , t({ "", "  (" })
    , i(2)
    , t({ ")", "  :" })
    , i(3)
    , t({ ".", "Proof.", "" })
    , i(4)
    , t({ "", "Admitted." })
    }
  ),
  s(
    { trig = "teo" },
    {
      t("Theorem")
      , i(1)
    , t({ "", "  (" })
    , i(2)
    , t({ ")", "  :" })
    , i(3)
    , t({ ".", "Proof.", "" })
    , i(4)
    , t({ "", "Admitted." })
    }
  ),
}
