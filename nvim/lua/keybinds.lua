local M = {}

local function nmap(command, value)
  vim.api.nvim_set_keymap('n', command, value, { noremap = true })
end

function M.setLeader()
  vim.g.mapleader = ","
  nmap("<leader>c", ":lua vim.lsp.buf.code_action()<CR>")
end

function M.setOrtographyKeybindings()
  -- TODO : make them configurable maybe?
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
  nmap('gp', ":lua vim.diagnostic.goto_prev()<CR>")
  nmap('gn', ":lua vim.diagnostic.goto_next()<CR>")
  nmap('gh', ":lua vim.lsp.buf.hover()<CR>")
  nmap('gd', ":lua vim.lsp.buf.definition()<CR>")
end

M.setWindowMovementKeyBinds = function()
  nmap('<C-D>', ':lua require(\'nvim-window\').pick()<CR>')
end

M.setAll = function()
  M.setLeader()
  M.setLspKeyBinds()
  M.setWindowMovementKeyBinds()
  M.setOrtographyKeybindings()
end

return M
