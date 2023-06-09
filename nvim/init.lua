require("nativeSettings").setMyDefaultSettings()
require('packerStartup')
require('lsp_config').setAll()
-- require('cmp_config')
require('keybinds').setAll()

vim.g.coq_settings = { auto_start = 'shut-up' }
vim.g.purescript_unicode_conceal_enable = 1
