return {
  cmd = { "lua-language-server" },
  filetypes = { 'lua' },
  root_markers =
  { ".luarc.json"
  , ".luarc.jsonc"
  , ".luacheckrc"
  , ".stylua.toml"
  , "stylua.toml"
  , "selene.toml"
  , "selene.yml"
  , ".git"
  },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      completion = {
        callSnippet = 'Replace',
        keywordSnippet = "Both"
      },
      diagnostics = {
        enable = true,
        globals = { 'vim', 'use' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        maxPreload = 10000,
        preloadFileSize = 10000,
      },
      telemetry = { enable = false },
    },
  }
}
