local autocmd_group = vim.api.nvim_create_augroup("PuresScript", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.purs"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
    ,
    group = autocmd_group
  })
