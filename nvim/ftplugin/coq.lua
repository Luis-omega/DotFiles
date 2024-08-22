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

local function dump(o)
  if type(o) == 'table' then
    local s = '{ '
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
    end
    return s .. '} '
  else
    return tostring(o)
  end
end


-- We want to format stuff like  "pose( name1 name2 name3 name4 ..) as H."
-- like:
--  """pose(
--       name1
--         name2
--         name3
--         name4
--         ...
--     ) as H.
local function format_parens()
  local bufnr = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- get line content
  local line = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1]

  -- start and end of more external parens
  local start_idx, end_idx = line:find("%b()")
  if not start_idx or start_idx > col or end_idx < col then
    print("No estás dentro de un paréntesis.")
    return
  end

  -- extract inner of parens
  local content = line:sub(start_idx + 1, end_idx - 1)

  -- Original line start
  local line_indent = line:match("^%s*")
  -- First item indent
  local indent = line_indent .. "  "

  -- The full line but with "\n"
  local formatted_content = line:sub(1, start_idx) .. "\n" .. indent .. content:gsub(" ", "\n" .. indent)

  -- remove the "\n" as buf_set_lines expect a table of strings without "\n"
  local lines = {}
  local counter = 1
  for line2 in formatted_content:gmatch("[^\n]*") do
    if #line2 > 0 then
      if counter > 3 then
        table.insert(lines, "  " .. line2)
      else
        table.insert(lines, line2)
      end
    end
    counter = counter + 1
  end

  -- Append the remain of the original line after the parens
  local next_line = line:sub(end_idx)
  if #next_line > 0 then
    table.insert(lines, line_indent .. next_line)
  end

  -- Replace the original line with the content
  vim.api.nvim_buf_set_lines(bufnr, row - 1, row, false, lines)

  -- put cursor after the paren
  vim.api.nvim_win_set_cursor(0, { row, start_idx + 1 })
end

-- nvim_buf_set_lines gave an error when we pass a function.
vim.keymap.set('n', "<leader>f", format_parens, { buffer = true, noremap = true })
