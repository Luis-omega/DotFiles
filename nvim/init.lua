--- Set the minimum level for neovim notifications
local function setLogLevel()
  local minLevel = vim.log.levels.WARN

  local original_notify = vim.notify
  vim.notify = function(msg, level, opts)
    level = level or vim.log.levels.WARN
    if level >= minLevel then
      original_notify(msg, level, opts)
    end
  end
end

setLogLevel()

local utils = require("utils")

--- Take a module name, load it and configure it.
--- @param name string
local function setAll(name)
  local module = utils.safeLoad(name)
  if module == nil then
    utils.error("Can't load configuration: " .. name)
  else
    utils.trace("setting: " .. name)
    module.setAll()
  end
end

--- Take a module name, load it and call setup it.
--- @param name string
local function setup(name)
  local module = utils.safeLoad(name)
  if module == nil then
    utils.error("Can't load configuration: " .. name)
  else
    utils.trace("setting: " .. name)
    module.setup()
  end
end

setAll("nativeSettings")
setup('lazyBootstrap')
setAll("indentation")
setAll("diagnostics")
setAll("completion")
setAll("treesitterConfiguration")
setup("vim-octizys")
setup("nvim-tree")

-- enable autocompletion while writing for every lsp
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/completion') then
      local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      client.server_capabilities.completionProvider.triggerCharacters = chars
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end
    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})

vim.lsp.enable({
  'coq'
  , 'haskell'
, 'lua_ls'
--, 'ltex'
, 'idris'
, 'prolog'
, 'purescript'
, 'pylsp'
, "rust-analyzer"
, "typescript"
})
