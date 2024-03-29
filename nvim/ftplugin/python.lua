local autocmd_group = vim.api.nvim_create_augroup("PythonLocal", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.py"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 10000 }) end
    ,
    group = autocmd_group
  })
