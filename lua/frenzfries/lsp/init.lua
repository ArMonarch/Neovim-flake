require('frenzfries.lsp.config.nix')
require('frenzfries.lsp.config.lua_ls')
require('frenzfries.lsp.config.pyright')
require('frenzfries.lsp.config.rust_analyzer')
require('frenzfries.lsp.config.ts_ls')
require('frenzfries.lsp.config.zls')

-- NOTE: Enable Language Servers here,
-- needs Neovim v0.11+, as it used functions available on Neovim version >= 0.11
vim.lsp.enable('nixd')
vim.lsp.enable('lua_ls')
vim.lsp.enable('pyright')
vim.lsp.enable('rust-analyzer')
vim.lsp.enable('ts_ls')
vim.lsp.enable('zls')

-- Enable Inlay Hints
vim.lsp.inlay_hint.enable(true)

--  This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function()
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { desc = desc})
    end

    -- NOTE: lsp keymaps
    map('n', 'gd', vim.lsp.buf.definition, 'Goto Defination' )
    map('n', 'gr', vim.lsp.buf.references, 'References' )
    map('n', 'gI', vim.lsp.buf.implementation, 'Goto Implementation')
    map('n', 'gy', vim.lsp.buf.type_definition, 'Goto T[y]pe Defination')
    map('n', 'gD', vim.lsp.buf.declaration, 'Goto Declaration')
    map('n', 'K', vim.lsp.buf.hover, 'Hover')
    -- map('n', 'gK', function() return vim.lsp.buf.signature_help() end, 'Signature Help')
    -- map('i', '<c-k>', function() return vim.buf.lsp.signature_help() end, 'Signature Help')
    -- map({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
    -- map({'n', 'v'}, '<leader>cc', vim.lsp.codelens.run, 'Code Lens')
    -- map('n', '<leader>cC', vim.lsp.codelens.refresh, 'Refresh & Display Code Lens')
    -- map('n', '<leader>cR', function() Snacks.rename.rename_file() end, 'Rename File')
    -- map('n', '<leader>cr', vim.lsp.buf.rename, 'Rename')
    -- TODO: Dynamically add these keymaps on condition Snacks.words.is_enabled()
    -- map('n', ']]', function() Snacks.words.jump(vim.v.count1) end, "Next Reference" )
    -- map('n', ']]', function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference" )
    -- map('n', '<a-n>', function() Snacks.words.jump(vim.v.count1) end, "Next Reference" )
    -- map('n', '<a-p>', function() Snacks.words.jump(-vim.v.count1) end, "Prev Reference" )
  end,
})

