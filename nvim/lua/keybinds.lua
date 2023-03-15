local M = {}

local function nmap(command, value)
  vim.api.nvim_set_keymap('n', command, value, { noremap = true })
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
  M.setLspKeyBinds()
  M.setWindowMovementKeyBinds()
end

return M
