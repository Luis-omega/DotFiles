local nativeSettings = {}

-- Things unrelated to plugins 

function nativeSettings.setRegularPropertyes()
  -- line numbers
  vim.o.number = true
  -- syntax highlight
  vim.o.syntax = "on"
  -- tabs as 2 spaces and change tabs to spaces
  vim.o.tabstop = 2
  vim.o.autoindent = true
  vim.o.expandtab = true
  vim.o.softtabstop=2
  vim.o.shiftwidth=2
  -- underline current cursor line or highlight it if termguicolors
  vim.o.cursorline = true
  -- highlight all search
  vim.o.hlsearch = true
  -- enable mouse support
  vim.o.mouse= "a"
  -- to save on buffer changes and others events
  vim.o.autowrite=true
  -- yes, this thing makes vim/nvim better.
  vim.o.termguicolors = true
  -- Obviously file type oriented plugins
  vim.cmd("filetype plugin on")
  -- If im intensively working in spanish I set this to es
  vim.o.spelllang="en"
  vim.o.spell = true
  -- is at the top left of my corne keyboard
  vim.g.mapleader = "½"
  -- mostly for vimtext but i can use it widely in my code
  vim.cmd("set conceallevel=2")
  -- popup menu options (transparency and height)
    -- transparency
    vim.o.pumblend=20
    -- height 
    vim.o.pumheight=10
    -- height
    vim.cmd('hi Pmenu guibg=#0059b3')
    vim.cmd('hi PmenuSel guibg=#3399ff')
    vim.cmd('hi DiagnosticError guifg=#ff6666')
end

function nativeSettings.regiterMistakenCommands()
  vim.cmd("command W :w")
  vim.cmd("command Wq :wq")
  vim.cmd("command WQ :wq")
  vim.cmd("command Qw :wq")
  vim.cmd("command QW :wq")
  vim.cmd("command Q :q")
end


function nativeSettings.rememberLastPosition()
  local command1 = "if line(\"'\\\"\") > 1 && line(\"'\\\"\") <= line(\"$\") | exe \"normal! "
  local command2 = "g'\\\"\" | endif"

  vim.api.nvim_create_autocmd({"BufReadPost"},
  {
    pattern = "*"
    ,command = command1 .. command2
  })
end

function nativeSettings.setOrtographyKeybindings()
  -- TODO : make them configurable maybe?
  local ortography= {
     key='z'
    ,next='j'
    ,prev='k'
  }
  local myApi =require"myApi"
  myApi.nmap(ortography.key .. ortography.next, ']s')
  myApi.nmap(ortography.key .. ortography.prev, '[s')
end

function nativeSettings.setMyDefaultSettings()
  nativeSettings.setRegularPropertyes()
  nativeSettings.regiterMistakenCommands()
  nativeSettings.rememberLastPosition()
  nativeSettings.setOrtographyKeybindings()
end

return nativeSettings
