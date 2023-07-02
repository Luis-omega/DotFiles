local M = {}

M.init_c = function()
  require 'lspconfig'.clangd.setup {}
end

M.init_haskell = function()
  local util = require 'lspconfig.util'
  require 'lspconfig'.hls.setup
  {
    default_config = {
      cmd = { 'haskell-language-server-wrapper', '--lsp' },
      filetypes = { 'haskell', 'lhaskell' },
      root_dir = function(filepath)
        return (
          util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
          or util.root_pattern('*.cabal', 'package.yaml')(filepath)
        )
      end,
      single_file_support = true,
      settings = {
        haskell = {
          formattingProvider = 'ormolu',
          cabalFormattingProvider = 'cabalfmt',
        },
      },
      lspinfo = function(cfg)
        local extra = {}
        local function on_stdout(_, data, _)
          local version = data[1]
          table.insert(extra, 'version:   ' .. version)
        end

        local opts = {
          cwd = cfg.cwd,
          stdout_buffered = true,
          on_stdout = on_stdout,
        }
        local chanid = vim.fn.jobstart({ cfg.cmd[1], '--version' }, opts)
        vim.fn.jobwait { chanid }
        return extra
      end,
    },

    docs = {
      description = [[
https://github.com/haskell/haskell-language-server

Haskell Language Server

If you are using HLS 1.9.0.0, enable the language server to launch on Cabal files as well:

```lua
require('lspconfig')['hls'].setup{
  filetypes = { 'haskell', 'lhaskell', 'cabal' },
}
```
    ]],

      default_config = {
        root_dir = [[
function (filepath)
  return (
    util.root_pattern('hie.yaml', 'stack.yaml', 'cabal.project')(filepath)
    or util.root_pattern('*.cabal', 'package.yaml')(filepath)
  )
end
      ]],
      },
    },
  }
  --require 'lspconfig'.hls.setup {
  --  cmd = { 'haskell-language-server', '--lsp' }
  --  ,
  --  filetypes = { 'haskell', 'lhaskell', 'tex.lhaskell', 'lhaskell.tex' }
  --  ,
  --  root_dir = require('lspconfig/util').root_pattern('*.cabal', 'stack.yaml', 'cabal.project', 'package.yaml',
  --    'hie.yaml')
  --  ,
  --  settings = {
  --    haskell = {
  --      formattingProvider = "fourmolu"
  --    }
  --  }
  --  ,
  --  on_attach = completion_callback
  --}
  -- require 'lspconfig'.hls.setup {
  --   cmd = { 'haskell-language-server', '--lsp' }
  --   , settings = {
  --   haskell = {
  --     formattingProvider = "fourmolu"
  --   }
  -- }
  -- , on_attach = completion_callback
  -- }
end


M.init_latex = function()
  require 'lspconfig'.texlab.setup {
    filetypes = { 'tex', 'tex.lhaskell', 'lhaskell.tex', 'lhaskell' },
    settings = {
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
          executable = "lualatex",
          forwardSearchAfter = false,
          onSave = false
        },
        chktex = {
          onEdit = false,
          onOpenAndSave = false
        },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = {
          args = {}
        },
        latexFormatter = "latexindent",
        latexindent = {
          modifyLineBreaks = false
        }
      }
    }
    , on_attach = completion_callback
  }
end

M.init_lua = function()
  require 'lspconfig'.lua_ls.setup(require("lsp-configs.lua"))
end

M.init_purescript = function()
  require 'lspconfig'.purescriptls.setup {
    on_attach = completion_callback,
    settings = {
      purescript = {
        addSpagoSources = true -- e.g. any purescript language-server config here
        ,
        formatter = "purs-tidy"
      }
    },
    flags = {
      debounce_text_changes = 150,
    }
  }
end

M.init_python = function()
  require 'lspconfig'.pylsp.setup {
    settings = {
      pylsp = {
        plugins = {
          black = {
            enable = true
            ,
            line_length = 80
          }
        }
      }
    }
  }
end

M.init_aiken = function()
  require 'lspconfig'.aiken.setup {
    cmd = { 'aiken', 'lsp' }
  }
end

M.lsp_symbols = function()
  local signs = {
    Error = '✘',
    Warn = '▲',
    Hint = '⚑',
    Info = ''
  }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

M.setAll = function()
  M.init_c()
  M.init_haskell()
  M.init_latex()
  M.init_lua()
  M.init_purescript()
  M.init_python()
  M.init_aiken()
end

return M
