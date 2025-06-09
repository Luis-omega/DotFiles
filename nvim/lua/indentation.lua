local M = {}

-- This module handles the configuration for the ibl plugin
-- for colored indentation.

--- Available colors
M.highlight = {
  "RainbowViolet",
  "RainbowCyan",
  "RainbowRed",
  "RainbowBlue",
  "RainbowYellow",
  "RainbowOrange",
  "RainbowGreen",
}

function M.mapColorNames()
  local utils = require("utils")
  local hooks = utils.safeLoad("ibl.hooks")
  if hooks == nil then
    vim.notify("Can't map color names to colors in indentation plugin.", vim.log.levels.WARN)
    return
  else
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
    end)
  end
end

function M.pluginSetup()
  local utils = require("utils")
  local ibl = utils.safeLoad("ibl")
  if ibl == nil then
    utils.warn("Can't setup ibl indentation plugin.")
  else
    ibl.setup {
      indent = { highlight = M.highlight },
      scope = { enabled = true,
        include = {
          node_type = {
            octizys =
            {
              "case_item", "pattern_parens", "expression_let", "data_type", "new_type"
            , "alias_type", "class_declaration", "instance_definition", "function_definition", "function_declaration"
            , "expression_lambda"
            }
          }
        }
      }
    }
  end
end

function M.setAll()
  M.mapColorNames()
  M.pluginSetup()
end

return M
