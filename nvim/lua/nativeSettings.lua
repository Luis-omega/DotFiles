local M = {}

local function nmap(command, value)
  vim.api.nvim_set_keymap('n', command, value, { noremap = true })
end

--Things unrelated to plugins or keybindings

--- Common settings of regular neovim like line numbers,
--- syntax highlight, mouse, etc.
function M.setRegularPropertyes()
  -- line numbers
  vim.o.number = true
  -- syntax highlight
  vim.o.syntax = "on"
  -- tabs as 2 spaces and change tabs to spaces
  vim.o.tabstop = 2
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.softtabstop = 2
  vim.o.shiftwidth = 2
  -- underline current cursor line or highlight it if termguicolors
  vim.o.cursorline = true
  -- highlight all search
  vim.o.hlsearch = true
  -- enable mouse support
  vim.o.mouse = "a"
  -- to save on buffer changes and others events
  vim.o.autowrite = true
  -- yes, this thing makes vim/nvim better.
  vim.o.termguicolors = true
  -- Obviously file type oriented plugins
  vim.cmd("filetype plugin on")
  -- If im intensively working in spanish I set this to es
  vim.o.spelllang = "en"
  vim.o.spell = true
  -- mostly for vimtext but i can use it widely in my code
  vim.cmd("set conceallevel=2")
  -- popup menu options (transparency and height)
  -- transparency
  vim.o.pumblend = 20
  -- height
  vim.o.pumheight = 10
  -- height
  vim.cmd('hi Pmenu guibg=#0059b3')
  vim.cmd('hi PmenuSel guibg=#3399ff')
  vim.cmd('hi DiagnosticError guifg=#ff6666')
  vim.o.completeopt = "fuzzy,menuone,noinsert,noselect,popup"
end

--- Register some usual mistakes like ":W" as aliases
--- for the right commands.
function M.regiterMistakenCommands()
  vim.cmd("command W :w")
  vim.cmd("command Wq :wq")
  vim.cmd("command WQ :wq")
  vim.cmd("command Qw :wq")
  vim.cmd("command QW :wq")
  vim.cmd("command Q :q")
end

--- A hack to restore position to last position.
function M.rememberLastPosition()
  local command1 = "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! "
  local command2 = "g'\\\"\" | endif"

  vim.api.nvim_create_autocmd({ "BufReadPost" },
    {
      pattern = "*"
      ,
      command = command1 .. command2
    })
end

--- Set leader key to " " in normal mode
function M.setLeader()
  local leaderKey = " "
  vim.keymap.set("n"
  , leaderKey
  , "<Nop>"
  , { silent = true, remap = false }
  )
  vim.g.mapleader = " "
end

--- Using [ and ] is very difficult to non English users. Instead we use "zj" and "zk"
function M.setOrtographyKeybindings()
  local ortography = {
    key = 'z'
    ,
    next = 'j'
    ,
    prev = 'k'
  }
  nmap(ortography.key .. ortography.next, ']s')
  nmap(ortography.key .. ortography.prev, '[s')
end

M.setLspKeyBinds = function()
  vim.api.nvim_set_keymap("n", "<leader>c", "",
    {
      noremap = true
      ,
      callback = vim.lsp.buf.code_action,
      desc = "Code actions from the lsp"
    })
  vim.api.nvim_set_keymap(
    "n"
    , "<leader>p"
    , ""
    , {
      noremap = true
      ,
      callback = function()
        vim.diagnostic.jump({ count = -1, float = true })
      end,
      desc = "Go to previous lsp error"
    })
  vim.api.nvim_set_keymap(
    "n"
    , "<leader>n"
    , ""
    , {
      noremap = true
      ,
      callback = function()
        vim.diagnostic.jump({ count = 1, float = true })
      end,
      desc = "Go to next lsp error"
    })
  vim.api.nvim_set_keymap(
    "n"
    , "<leader>h"
    , ""
    , {
      noremap = true
      ,
      callback = vim.lsp.buf.hover,
      desc = "Show hover information"
    })
  vim.api.nvim_set_keymap(
    "n"
    , "<leader>d"
    , ""
    , {
      noremap = true
      ,
      callback = vim.lsp.buf.definition,
      desc = "Show definition information"
    })
  vim.api.nvim_set_keymap(
    "n"
    , "<leader>r"
    , ""
    , {
      noremap = true
      ,
      callback = vim.lsp.buf.rename,
      desc = "Lsp rename function"
    })
end

M.setWindowMovementKeyBinds = function()
  nmap('<leader>w', ':lua require(\'nvim-window\').pick()<CR>')
end

M.setNoJumpAtParen = function()
  -- My custom keyboard keeps creating `)` instead of j
  nmap(")", "j")
end

--- Enable all keybindings.
function M.setAllKeyBinds()
  M.setLeader()
  M.setLspKeyBinds()
  M.setWindowMovementKeyBinds()
  M.setOrtographyKeybindings()
  M.setNoJumpAtParen()
end

--- Set all the options of neovim that can be used without plugins.
function M.setAll()
  M.setRegularPropertyes()
  M.regiterMistakenCommands()
  M.rememberLastPosition()
  M.setAllKeyBinds()
end

return M
