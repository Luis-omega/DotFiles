local main = {}

local myApi = require("myApi")

function main.setAll()
  require("language_configs.haskell")
  require("language_configs.lua")
  require("language_configs.python")
  require("language_configs.purescript")
  require("language_configs.latex")
  require("language_configs.c")
  require("language_configs.coq")
end

return main
