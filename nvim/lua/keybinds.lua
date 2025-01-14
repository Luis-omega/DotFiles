local M = {}

local function nmap(command, value)
  vim.api.nvim_set_keymap('n', command, value, { noremap = true })
end

function M.setLeader()
  vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
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
  vim.api.nvim_set_keymap("n", "<leader>c", "",
    { noremap = true, callback = vim.lsp.buf.code_action, desc = "Code actions from the lsp" })
  -- TODO: There are more complex functions I can put here, we can:
  -- - Divide the errors in spell and not spell.
  -- - Go only to next no spell error.
  -- - Go only to spell error and open code actions.
  -- - If not lsp available use quickfix and do :cn
  -- - Add cyclic search
  vim.api.nvim_set_keymap("n", "<leader>p", "",
    { noremap = true, callback = vim.lsp.buf.goto_prev, desc = "Go to next lsp error" })
  -- TODO: finish the refactor.
  nmap('<leader>p', ":lua vim.diagnostic.goto_prev()<CR>")
  nmap('<leader>n', ":lua vim.diagnostic.goto_next()<CR>")
  nmap('<leader>h', ":lua vim.lsp.buf.hover()<CR>")
  nmap('<leader>d', ":lua vim.lsp.buf.definition()<CR>")
  nmap('<leader>r', ":lua vim.lsp.buf.rename()<CR>")
end

M.setWindowMovementKeyBinds = function()
  nmap('<leader>w', ':lua require(\'nvim-window\').pick()<CR>')
end

M.setDumbFormatter = function()
  vim.keymap.set("v", "<leader>f", ":%!dumb_formatter.py<CR>")
end

M.setNoJumpAtParen = function()
  -- My custom keyboard keeps creating `)` instead of j
  nmap(")", "j")
end

M.setAll = function()
  M.setLeader()
  M.setLspKeyBinds()
  M.setWindowMovementKeyBinds()
  M.setOrtographyKeybindings()
  M.setDumbFormatter()
  M.setNoJumpAtParen()
end

return M
