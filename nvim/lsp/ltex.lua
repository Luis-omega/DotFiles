local dictionary = {}
dictionary["en-GB"] = {
  "TODO", "onchain"
, "Daiyatsu", "newtype", "octizys", "Octizys", "FIXME", "REPL" }
local filetypes = {
  "bib",
  "gitcommit",
  "markdown",
  "org",
  "plaintex",
  "rst",
  "rnoweb",
  "tex",
  "pandoc",
  "rust",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "lua",
  -- "python",
  "html",
  "lhaskell",
}
return {
  cmd = { "ltex-ls" },
  filetypes = filetypes,
  settings = {
    ltex = {
      language = "en-GB",
      enabled = filetypes,
      additionalRules = {
        languageModel = '~/ngrams/',
        motherTongue = "es",
        enablePickyRules = true,
        completionEnabled = true,
      },
      dictionary = dictionary
    },
  },
}
