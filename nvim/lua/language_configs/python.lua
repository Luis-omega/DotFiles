require'lspconfig'.pylsp.setup{}

vim.api.nvim_create_autocmd({"BufWritePre"},
  {
    pattern = "*.py"
    ,callback = function () vim.lsp.buf.formatting_sync(nil, 100) end
  })
