local myApi = require "myApi"

require 'lspconfig'.hls.setup { default_config = {
  filetypes = { 'haskell', 'lhaskell', 'tex.lhaskell', 'lhaskell.tex' }
  ,
  root_dir = require('lspconfig/util').root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml', 'hie.yaml')
}
}

require 'lspconfig'.hls.setup {
  cmd = { 'haskell-language-server', '--lsp' }
  , settings = {
  haskell = {
    formattingProvider = "fourmolu"
  }
}
, on_attach = completion_callback
}

local haskellAutocmdGroup = vim.api.nvim_create_augroup("Haskell", { clear = true })

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.hs"
    ,
    callback = function() vim.lsp.buf.formatting_sync(nil, 100) end
    ,
    group = haskellAutocmdGroup
  })


-- depends on zfc and an available hoogle instance

vim.api.nvim_create_autocmd({ "BufWritePre" },
  {
    pattern = "*.hs"
    ,
    callback =
        function()
          myApi.nmap('gf', ':execute ":Hoogle " . expand(\'<cword>\')<esc>')
        end
    ,
    group = haskellAutocmdGroup
  })
