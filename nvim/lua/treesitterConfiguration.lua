local M = {}

--- Generate the path used for parsers
--- @return string
function M.getParsersPath()
  local dataPath = os.getenv('XDG_DATA_HOME')

  local parsersPath = nil

  if dataPath ~= nil then
    parsersPath = dataPath .. "/parsers"
  else
    parsersPath = vim.fn.stdpath("data") .. "/site"
  end
  return parsersPath
end

--- Add a path to neovim runtime.
--- @param path string
function M.addParserPath(path)
  vim.opt.runtimepath:prepend(path)
end

--- Generate the configuration for neovim tree sitter.
---@param parsersPath string
---@return table
function M.makeNvimTreesitterConfig(parsersPath)
  return {
    parser_install_dir = parsersPath,
    highlight = {
      enable = true,
      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = false
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = false },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "<leader>tr",
        },
      },
    }
  }
end

function M.nvimTreeSitterSetup()
  local parsersPath = M.getParsersPath()
  local config = M.makeNvimTreesitterConfig(parsersPath)
  local utils = require("utils")
  local lib = utils.safeLoad("nvim-treesitter.configs")
  if lib == nil then
    utils.warn("Can't setup neovim treesitter")
  else
    lib.setup(config)
  end
end

function M.addOctizys()
  local utils = require("utils")
  local parsers = utils.safeLoad("nvim-treesitter.parsers")
  if parsers == nil then
    utils.warn("Can't load tree sitter parsers configuration")
  else
    local parsersConfig = parsers.get_parser_configs()
    parsersConfig.octizys = {
      install_info = {
        url = "~/projects/tree-sitter-octizys", -- local path or git repo
        files = { "src/parser.c" },             -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main",                        -- default branch in case of git repo if different from master
        generate_requires_npm = true,           -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      },
      filetype = "octizys",                     -- if filetype does not match the parser name
    }
  end
end

function M.setAll()
  local path = M.getParsersPath()
  M.addParserPath(path)
  M.nvimTreeSitterSetup()
  M.addOctizys()
end

return M
