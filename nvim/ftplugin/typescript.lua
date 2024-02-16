local autocmd_group = vim.api.nvim_create_augroup("TypeScriptLocal", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.ts"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 10000 }) end
    ,
    group = autocmd_group
  })
