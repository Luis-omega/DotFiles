local M = {}


--- Set the default colorscheme
function M.setColorScheme()
  local utils = require("utils")
  local colorSchemeName = "tokyonight-night"
  local status, errorMsg = pcall(function()
    vim.cmd.colorscheme(colorSchemeName)
  end)
  if status then
    return
  else
    utils.error("Can't find color scheme: " .. colorSchemeName .. " " .. errorMsg)
  end
end

--- Change the default color scheme to match my liking
function M.setColors()
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
end

--- Set the default color scheme and modify it to match
--- my linking
function M.setAll()
  M.setColorScheme()
  M.setColors()
end

return M
