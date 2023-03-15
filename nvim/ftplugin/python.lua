local autocmd_group = vim.api.nvim_create_augroup("Haskell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.py"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
    ,
    group = autocmd_group
  })
