local M = {}

-- Bootstrap lazy.nvim
local utils = require("utils")


--- Get the local path to the lazy folder
---@return string
function M.getLazyPath()
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  return lazypath
end

--- Check if lazy is installed in the given path
---@param path string
---@return boolean
function M.isLazyInstalledInPath(path)
  return (vim.uv or vim.loop).fs_stat(path)
end

--- Clones the lazy repo to the given path, returns nil
--- if the clone returns without errors, false otherwise.
---@param path any
---@return nil | string
function M.installLazyInPath(path)
  -- TODO: remove this harcoded url? it won't change often...
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, path })
  if vim.v.shell_error == 0 then
    return nil
  else
    return out
  end
end

--- If the given message is not nil, reports the message as an
--- error and closes neovim.
---@param errorMessage nil|string
---@return nil
function M.exitOnError(errorMessage)
  if errorMessage ~= nil then
    return
  else
    utils.error(
      errorMessage ..
      "\nPress any key to exit..."
    )
    vim.fn.getchar()
    os.exit(1)
  end
end

--- Checks if lazy is in place and if not, attempt to install it.
--- On installation failure this exits neovim!
---@return string
function M.checkInstallationOrInstall()
  local path = M.getLazyPath()
  if M.isLazyInstalledInPath(path) then
    return path
  else
    local errorMsg = M.installLazyInPath(path)
    if errorMsg ~= nil then
      M.exitOnError("Can't clone lazy nvim!\n" .. errorMsg)
    end
    return path
  end
end

--- Adds the given path to the runtime paths.
---@param path string
function M.addPathToRuntime(path)
  vim.opt.rtp:prepend(path)
end

-- Setup lazy.nvim
function M.launchLazySetup()
  local lazy = utils.safeLoad("lazy")
  if lazy == nil then
    M.exitOnError("Can't load lazy module!")
  else
    lazy.setup({
      spec = {
        -- import your plugins
        { import = "lazy_plugins" },
      },
      -- Configure any other settings here. See the documentation for more details.
      -- colorscheme that will be used when installing plugins.
      install = { colorscheme = { "habamax" } },
      -- automatically check for plugin updates
      checker = { enabled = true },
      dev = {
        path = "~/projects"
        ,
        patterns = { "vim-octizys" }
        ,
        fallback = true
      }
    })
  end
end

function M.setup()
  local lazyPath = M.checkInstallationOrInstall()
  M.addPathToRuntime(lazyPath)
  M.launchLazySetup()
end

return M
