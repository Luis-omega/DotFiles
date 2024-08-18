local M = {}

local function nmap(command, value)
  vim.api.nvim_set_keymap('n', command, value, { noremap = true })
end

function M.setLeader()
  vim.g.mapleader = " "
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
  nmap("<leader>c", ":lua vim.lsp.buf.code_action()<CR>")
  nmap('<leader>p', ":lua vim.diagnostic.goto_prev()<CR>")
  nmap('<leader>n', ":lua vim.diagnostic.goto_next()<CR>")
  nmap('<leader>h', ":lua vim.lsp.buf.hover()<CR>")
  nmap('<leader>d', ":lua vim.lsp.buf.definition()<CR>")
  nmap('<leader>r', ":lua vim.lsp.buf.rename()<CR>")
end

M.setWindowMovementKeyBinds = function()
  nmap('<leader>w', ':lua require(\'nvim-window\').pick()<CR>')
end

M.setAll = function()
  M.setLeader()
  M.setLspKeyBinds()
  M.setWindowMovementKeyBinds()
  M.setOrtographyKeybindings()
end

return M
