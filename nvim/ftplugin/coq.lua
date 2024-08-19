function vim.g.CoqtailHighlight()
  vim.cmd [[hi def CoqtailChecked guifg=white guibg=#008000]]
  vim.cmd [[hi def CoqtailSent guifg=black guibg=#d24dff]]
end

local current_buffer = 0

local map = function(command, value)
  vim.api.nvim_buf_set_keymap(current_buffer, "n", command, value, { noremap = true })
end

map("gn", ":CoqNext<CR>")
map("gp", ":CoqUndo<CR>")
map("gl", ":CoqToLine<CR>")
vim.g.coqtail_noimap = true;
vim.g.coqtail_nomap = true;
