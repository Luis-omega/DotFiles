require'lspconfig'.clangd.setup{}

vim.api.nvim_create_autocmd({"BufWritePre"},
  {
    pattern = "*.c"
    ,callback = function () vim.lsp.buf.formatting_sync(nil, 100) end
  })
