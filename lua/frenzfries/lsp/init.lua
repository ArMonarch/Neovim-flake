-- Set root markers for ALL clients
vim.lsp.config('*', {
  root_markers = { '.git', '.hg' },
})

require('frenzfries.lsp.config.nix')
require('frenzfries.lsp.config.lua_ls')

-- NOTE: Enable Language Servers here,
-- needs Neovim v0.11+, as it used functions available on Neovim version >= 0.11
vim.lsp.enable('nixd')
vim.lsp.enable('lua_ls')
