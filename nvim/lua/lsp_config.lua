local M = {}


M.generate_c = function()
  return {}
end

M.generate_haskell = function()
  local util = require 'lspconfig.util'
  return {
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
end


M.generate_latex = function()
  return {
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
    ,
    on_attach = completion_callback
  }
end

M.generate_lua = function()
  return require("lsp-configs.lua")
end

M.generate_coq = function()
  return {}
end

M.generate_idris = function()
  local lspconfig = require('lspconfig')
  local autostart_semantic_highlightning = true
  return {
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

M.generate_purescript = function()
  return {
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

M.generate_python = function()
  return {
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

M.generate_aiken = function()
  return {
    cmd = { 'aiken', 'lsp' }
  }
end

M.generate_ltex = function()
  local dictionary = {}
  dictionary["en-GB"] = {
    "TODO", "onchain"
  , "Daiyatsu", "newtype", "octizys", "Octizys", "FIXME", "REPL" }
  local filetypes = {
    "bib",
    "gitcommit",
    "markdown",
    "org",
    "plaintex",
    "rst",
    "rnoweb",
    "tex",
    "pandoc",
    "rust",
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "lua",
    "python",
    "html",
    "lhaskell",
  }
  return {
    filetypes = filetypes,
    settings = {
      cmd = { "ltex-ls" },
      ltex = {
        language = "en-GB",
        enabled = filetypes,
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

M.generate_rust = function()
  return {
    settings = {
      filetypes = { "rust" },
      ['rust-analyzer'] = {
        diagnostics = {
          enable = false,
        },
        completion = { postfix = { enable = true }, autoimport = { enable = true } },
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
  local prefix_format = function(diagnostic, _indext, _total)
    if (diagnostic == nil or diagnostic.severity == nil) then
      return signs["Error"]
    end
    print("reached format")
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      return signs["Error"]
    end
    if diagnostic.severity == vim.diagnostic.severity.WARN then
      return signs["Warn"]
    end
    if diagnostic.severity == vim.diagnostic.severity.INFO then
      return signs["Info"]
    end
    if diagnostic.severity == vim.diagnostic.severity.HINT then
      return signs["Hint"]
    end
  end
  vim.diagnostic.config({
    virtual_text = {
      prefix = prefix_format,
      source = "if_many",
      severity_sort = true,
      float = {
        source = "if_many",
        severity_sort = true,
      }
    },
    float = {
      severity_sort = true,
      prefix = prefix_format
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs["Error"],
        [vim.diagnostic.severity.WARN] = signs["Warn"],
        [vim.diagnostic.severity.INFO] = signs["Info"],
        [vim.diagnostic.severity.HINT] = signs["Hint"],
      }
    }

  })
end

M.generate_typescript = function()
  return { cmd = { "npx", "typescript-language-server", "--stdio" },
  }
end

M.generate_koka = function()
  return {}
end


M.configurations = {
  -- ltex
  ltex = { lsp = "ltex", config = M.generate_ltex() },
  -- clangd
  c = { lsp = "clangd", config = M.generate_c() },
  -- hls
  haskell = { lsp = "hls", config = M.generate_haskell() },
  -- textlab
  latex = { lsp = "textlab", config = M.generate_latex() },
  -- lua_ls
  lua = { lsp = "lua_ls", config = M.generate_lua() },
  -- coq_lsp
  coq = { lsp = "coq_lsp", config = M.generate_coq() },
  -- idris2_lsp
  idris = { lsp = "idris2_lsp", config = M.generate_idris() },
  -- purescripttls
  purescript = { lsp = "purescripttls", config = M.generate_purescript() },
  -- pylsp
  python = { lsp = "pylsp", config = M.generate_python() },
  -- aiken
  aiken = { lsp = "aiken", config = M.generate_aiken() },
  -- rust_analyzer
  rust = { lsp = "rust_analyzer", config = M.generate_rust() },
  -- ts_ls
  typescript = { lsp = "ts_ls", config = M.generate_typescript() },
  -- koka
  koka = { lsp = "koka", config = M.generate_koka() },
}

return M
