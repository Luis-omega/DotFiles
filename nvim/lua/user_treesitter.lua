local data_path = require("environment_variables").data

local parsers_path = nil

if data_path ~= nil then
  parsers_path = data_path .. "/parsers"
else
  parsers_path = vim.fn.stdpath("data") .. "/site"
end
vim.opt.runtimepath:prepend(parsers_path)

require 'nvim-treesitter.configs'.setup {
  parser_install_dir = parsers_path,
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

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.octizys = {
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
parser_config.koka = {
  install_info = {
    url = "https://github.com/mtoohey31/tree-sitter-koka", -- local path or git repo
    files = { "src/parser.c", "src/scanner.c" },           -- note that some parsers also require src/scanner.c or src/scanner.cc
    -- optional entries:
    branch = "main",                                       -- default branch in case of git repo if different from master
    generate_requires_npm = true,                          -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false,                -- if folder contains pre-generated src/parser.c
  },
  filetype = "koka",                                       -- if filetype does not match the parser name
}
