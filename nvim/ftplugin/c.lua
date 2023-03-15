local autocmd_group = vim.api.nvim_create_augroup("C", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.c"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
    ,
    group = autocmd_group
  })
