local autocmd_group = vim.api.nvim_create_augroup("RustLocal", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.rs"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 10000 }) end
    ,
    group = autocmd_group
  })
