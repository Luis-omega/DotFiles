-- vim.cmd.colorscheme('tokyonight-night')
vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight NormalNC guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight NormalNC ctermbg=none
  highlight LineNr guifg=Gray
  highlight Comment guifg=#7aa2f7
]]
function dump(o)
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

require("nativeSettings").setMyDefaultSettings()
require('packerStartup')
require("luasnip.loaders.from_vscode").lazy_load()
require('cmp_config')
require('lsp_config').lsp_symbols()
require("indent")
require("user_treesitter")
require('keybinds').setAll()
require("nvim-tree").setup()
vim.g.purescript_unicode_conceal_enable = 1
-- I'm the creator and the default configuration
-- is what I use
-- require("vim-octizys").setup()

local find_buffer_by_name = function(name)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name == name then
      return buf
    end
  end
  return -1
end

Query = function(query)
  print(query)
  local query = vim.treesitter.query.parse('rust', query)

  print(vim.inspect(query))

  local buffer = vim.api.nvim_get_current_buf()

  local parser = vim.treesitter.get_parser(buffer, "rust")

  local tree_table = parser:parse(false)
  local buffer_name = "/strings_on_file"
  local new_buffer = find_buffer_by_name(buffer_name)
  print("result of lookup: " .. new_buffer)
  if new_buffer == -1 then
    new_buffer = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_name(new_buffer, buffer_name)
    vim.lsp.buf_attach_client(new_buffer, 1)
    vim.api.nvim_set_option_value("buftype", "nofile", { buf = new_buffer })
    vim.api.nvim_set_option_value("filetype", "plaintext", { buf = new_buffer })
  end
  vim.api.nvim_buf_set_lines(new_buffer, 0, -1, true, { "" })
  local strings = {}
  for _, tst in pairs(tree_table) do
    local root = tst:root()
    print("hi")
    for _, node, _, _ in query:iter_captures(root, buffer) do
      table.insert(strings, vim.treesitter.get_node_text(node, buffer))
      table.insert(strings, "")
    end
  end
  vim.api.nvim_buf_set_lines(new_buffer, -1, -1, true, strings)
end

local query_strings = function()
  Query("(string_literal (string_content)) @string")
  vim.cmd [[ :vs /strings_on_file ]]
end

vim.keymap.set('n', '<leader>a', query_strings)
