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

M.init_idris = function()
  -- require 'lspconfig'.idris2_lsp.setup(require("lsp-configs.lua"))
  local lspconfig = require('lspconfig')
  local autostart_semantic_highlightning = true
  lspconfig.idris2_lsp.setup {
    on_new_config = function(new_config, new_root_dir)
      new_config.capabilities['workspace']['semanticTokens'] = { refreshSupport = true }
    end,
    on_attach = function(client)
      if autostart_semantic_highlightning then
        vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
          { textDocument = vim.lsp.util.make_text_document_params() }, nil)
      end
      -- Example of how to request a single kind of code action with a keymap,
      -- refer to the table in the README for the appropriate key for each command.
      vim.cmd [[nnoremap <Leader>cs <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.CaseSplit"}})<CR>]]
      vim.cmd [[nnoremap <Leader>cd <Cmd>lua vim.lsp.buf.code_action({diagnostics={},only={"refactor.rewrite.GenerateDef"}})<CR>]]
      --custom_attach(client) -- remove this line if you don't have a customized attach function
    end,
    autostart = true,
    handlers = {
      ['workspace/semanticTokens/refresh'] = function(err, params, ctx, config)
        if autostart_semantic_highlightning then
          vim.lsp.buf_request(0, 'textDocument/semanticTokens/full',
            { textDocument = vim.lsp.util.make_text_document_params() }, nil)
        end
        return vim.NIL
      end,
      ['textDocument/semanticTokens/full'] = function(err, result, ctx, config)
        -- temporary handler until native support lands
        local bufnr = ctx.bufnr
        local client = vim.lsp.get_client_by_id(ctx.client_id)
        local legend = client.server_capabilities.semanticTokensProvider.legend
        local token_types = legend.tokenTypes
        local data = result.data

        local ns = vim.api.nvim_create_namespace('nvim-lsp-semantic')
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        local tokens = {}
        local prev_line, prev_start = nil, 0
        for i = 1, #data, 5 do
          local delta_line = data[i]
          prev_line = prev_line and prev_line + delta_line or delta_line
          local delta_start = data[i + 1]
          prev_start = delta_line == 0 and prev_start + delta_start or delta_start
          local token_type = token_types[data[i + 3] + 1]
          local line = vim.api.nvim_buf_get_lines(bufnr, prev_line, prev_line + 1, false)[1]
          local byte_start = vim.str_byteindex(line, prev_start)
          local byte_end = vim.str_byteindex(line, prev_start + data[i + 2])
          vim.api.nvim_buf_add_highlight(bufnr, ns, 'LspSemantic_' .. token_type, prev_line, byte_start, byte_end)
        end
      end
    },
  }
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
            enabled = true
            ,
            line_length = 80,
          },
          rope_autoimport = {
            enabled = true
          },
          rope_completion = {
            enabled = true
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

M.init_ltex = function()
  local dictionary = {}
  dictionary["en-GB"] = {
    "Arweave", "UTxO", "UTxOs", "TODO", "onchain", "DeNS"
  , "IPFS", "Plutus" }
  require 'lspconfig'.ltex.setup {
    settings = {
      ltex = {
        language = "en-GB",
        additionalRules = {
          languageModel = '~/ngrams/',
          motherTongue = "es",
          enablePickyRules = true,
          completionEnabled = true,
        },
        dictionary = dictionary
      },
    },
  }
end

M.init_rust = function()
  require 'lspconfig'.rust_analyzer.setup {
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false,
        }
      }
    }
  }
end


M.lsp_symbols = function()
  local signs = {
    Error = '✘',
    Warn = '▲',
    Hint = '⚑',
    Info = ''
  }
  -- TODO: enable when we upgrade neovim
  prefix_format = function(diagnostic, indext, total)
    if diagnostic == vim.diagnostics.serverity.ERROR then
      return signs["Error"]
    end
    if diagnostic == vim.diagnostics.serverity.WARN then
      return signs["Warn"]
    end
    if diagnostic == vim.diagnostics.serverity.INFO then
      return signs["Info"]
    end
    if diagnostic == vim.diagnostics.serverity.HINT then
      return signs["Hint"]
    end
  end
  vim.diagnostic.config({
    virtual_text = {
      prefix = signs["Error"],
      source = "if_many",
      severity_sort = true,
      float = {
        source = "if_many",
        severity_sort = true,
      }
    }
  })
end

M.init_typescript = function()
  require 'lspconfig'.tsserver.setup { cmd = { "npx", "typescript-language-server", "--stdio" } }
end

M.setAll = function()
  M.init_c()
  M.init_haskell()
  M.init_latex()
  M.init_lua()
  M.init_purescript()
  M.init_python()
  M.init_aiken()
  M.init_idris()
  M.init_ltex()
  M.init_typescript()
  M.lsp_symbols()
end

return M
