local autocmd_group = vim.api.nvim_create_augroup("PuresScript", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.purs"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end
    ,
    group = autocmd_group
  })
