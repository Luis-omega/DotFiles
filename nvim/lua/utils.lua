local M = {}

--- Log a warning
--- @param msg string
function M.warn(msg)
  vim.notify(msg, vim.log.levels.WARN)
end

--- Log an error
--- @param msg string
function M.error(msg)
  vim.notify(msg, vim.log.levels.ERROR)
end

--- Log a trace message.
--- @param msg string
function M.trace(msg)
  vim.notify(msg, vim.log.levels.TRACE)
end

--- Load the module or send a warning.
--- @param module_name string
--- @return nil| table
function M.safeLoad(module_name)
  local ok, module = pcall(require, module_name)
  if ok then
    return module
  else
    M.warn("Error loading " .. module)
    return nil
  end
end

return M
