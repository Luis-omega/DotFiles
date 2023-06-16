local autocmd_group = vim.api.nvim_create_augroup("Aiken", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.ak"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end
    ,
    group = autocmd_group
  })
