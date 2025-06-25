-- TODO: Lua Language Server Configuration setup needed?
-- lazydev already setups the lua-language-server ready for lua development,
-- is the extra Configuration as from nvim-lsp for lua needed?

vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
  },
})
