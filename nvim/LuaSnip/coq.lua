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
    , t({ "", "end." })
    }
  ),


}
