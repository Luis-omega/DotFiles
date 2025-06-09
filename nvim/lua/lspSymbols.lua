local M = {}
function M.setSymbols()
  local signs = {
    Error = '✘',
    Warn = '▲',
    Hint = '⚑',
    Info = ''
  }
  local prefix_format = function(diagnostic, _indext, _total)
    if (diagnostic == nil or diagnostic.severity == nil) then
      return signs["Error"]
    end
    print("reached format")
    if diagnostic.severity == vim.diagnostic.severity.ERROR then
      return signs["Error"]
    end
    if diagnostic.severity == vim.diagnostic.severity.WARN then
      return signs["Warn"]
    end
    if diagnostic.severity == vim.diagnostic.severity.INFO then
      return signs["Info"]
    end
    if diagnostic.severity == vim.diagnostic.severity.HINT then
      return signs["Hint"]
    end
  end
  vim.diagnostic.config({
    virtual_text = {
      prefix = prefix_format,
      source = "if_many",
      severity_sort = true,
      float = {
        source = "if_many",
        severity_sort = true,
      }
    },
    float = {
      severity_sort = true,
      prefix = prefix_format
    },
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = signs["Error"],
        [vim.diagnostic.severity.WARN] = signs["Warn"],
        [vim.diagnostic.severity.INFO] = signs["Info"],
        [vim.diagnostic.severity.HINT] = signs["Hint"],
      }
    }

  })
end

function M.setAll()
  M.setSymbols()
end

return M
