require 'lspconfig'.purescriptls.setup {
  on_attach = completion_callback,
  settings = {
    purescript = {
      addSpagoSources = true -- e.g. any purescript language-server config here
      ,
      formatter = "purs-tidy"
    }
  },
  flags = {
    debounce_text_changes = 150,
  }
}

local purescriptAutocmdGroup = vim.api.nvim_create_augroup("PuresScript", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.purs"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
    ,
    group = purescriptAutocmdGroup
  })
