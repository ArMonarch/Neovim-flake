-- load set vim options
require("frenzfries.options")

-- NOTE: Add LSP & Plugins before keymaps and autocmds as some
-- of the keymaps and autocmd depend upon these plugins
-- NOTE: module for configuring LSPs
require('frenzfries.lsp')

-- load plugins
require("frenzfries.plugins")

-- load set vim keymaps
require("frenzfries.keymaps")

-- load set vim autocmds
require("frenzfries.autocmds")
