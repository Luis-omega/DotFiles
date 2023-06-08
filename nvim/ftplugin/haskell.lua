local autocmd_group = vim.api.nvim_create_augroup("Haskell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.hs"
    ,
    callback = function() vim.lsp.buf.format({ timeout_ms = 1000 }) end
    ,
    group = autocmd_group
  })


-- depends on zfc and an available hoogle instance

-- vim.api.nvim_create_autocmd({ "BufWritePre" },
--   {
--     pattern = "*.hs"
--     ,
--     callback =
--         function()
--           vim.api.nvim_set_keymap('<buffer>gf', ':execute ":Hoogle " . expand(\'<cword>\')<esc>')
--         end
--     ,
--     group = autocmd_group
--   })
