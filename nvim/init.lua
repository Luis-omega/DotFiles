vim.cmd.colorscheme('vim')
require("nativeSettings").setMyDefaultSettings()
require('packerStartup')
require('lsp_config').setAll()
require("luasnip.loaders.from_vscode").lazy_load()
require('cmp_config')
require('keybinds').setAll()
vim.g.purescript_unicode_conceal_enable = 1
