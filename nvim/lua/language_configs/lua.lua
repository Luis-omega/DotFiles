require 'lspconfig'.lua_ls.setup(require("lsp-configs.lua"))


vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.lua"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
  })
