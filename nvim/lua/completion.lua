local M = {}

local selectNextString = vim.api.nvim_replace_termcodes("<C-N>", true, false, true)
local selectPreviousString = vim.api.nvim_replace_termcodes("<C-P>", true, false, true)
local escCode = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
local abortSelection = vim.api.nvim_replace_termcodes("<C-e><Esc>", true, false, true)
local acceptSelection = vim.api.nvim_replace_termcodes("<C-y>", true, false, true)
local introCode = vim.api.nvim_replace_termcodes("<CR>", true, false, true)

--- The function that handles a press of tab
--- @return string
local function tabHandler()
  if vim.fn.pumvisible() ~= 0 then
    return selectNextString
  else
    return "\t"
  end
end

local function stabHandler()
  if vim.fn.pumvisible() ~= 0 then
    return selectPreviousString
  else
    return ""
  end
end



local function escHandler()
  if vim.fn.pumvisible() ~= 0 then
    return abortSelection
  else
    return escCode
  end
end

local function introHandler()
  if vim.fn.pumvisible() ~= 0 then
    return acceptSelection
  else
    return introCode
  end
end


M.setCompletion = function()
  vim.keymap.set('i', '<Tab>', tabHandler
  , {
    expr = true,
    remap = false,
    desc = "Set the tab key to move after completion item."
  })
  vim.keymap.set('i', '<S-Tab>', stabHandler
  , {
    expr = true,
    remap = false,
    desc = "Set the shift + tab key to move before the completion item."
  })
  vim.keymap.set('i', '<Esc>', escHandler
  , {
    expr = true,
    remap = false,
    desc = "Custom close of pumb menu"
  })
  vim.keymap.set('i', '<CR>', introHandler
  , {
    expr = true,
    remap = false,
    desc = "Custom selection of pumb menu"
  })
end


function M.setAll()
  M.setCompletion()
end

return M
