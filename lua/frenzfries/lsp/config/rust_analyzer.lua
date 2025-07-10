---@brief
---
--- https://github.com/rust-lang/rust-analyzer
---
--- rust-analyzer (aka rls 2.0), a language server for Rust
---
---
--- See [docs](https://rust-analyzer.github.io/book/configuration.html) for extra settings. The settings can be used like this:
--- ```lua
--- vim.lsp.config('rust_analyzer', {
---   settings = {
---     ['rust-analyzer'] = {
---       diagnostics = {
---         enable = false;
---       }
---     }
---   }
--- })
--- ```
---
--- Note: do not set `init_options` for this LS config, it will be automatically populated by the contents of settings["rust-analyzer"] per
--- https://github.com/rust-lang/rust-analyzer/blob/eb5da56d839ae0a9e9f50774fa3eb78eb0964550/docs/dev/lsp-extensions.md?plain=1#L26.

local function reload_workspace(bufnr)
  local clients = vim.lsp.get_clients({ bufnr = bufnr, name = 'rust_analyzer' })
  for _, client in ipairs(clients) do
    client.request(client, 'rust-analyzer/reloadWorkspace', nil, function (err)
      if err then
        error(tostring(err))
      end
    end, 0)
  end
end

vim.lsp.config('rust-analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspCargoReload', function()
      reload_workspace(bufnr)
    end, { desc = 'Reload current cargo workspace' })

    -- autocommand to reload cargo workspace on save
    vim.api.nvim_create_autocmd('BufWritePost', {
      desc = 'Reload Current Cargo Workspace',
      group = vim.api.nvim_create_augroup('cargo-reload', { clear = true }),
      pattern = {'*.rs'},
      callback = function()
        vim.notify('Reloading Cargo Workspace')
        reload_workspace(bufnr)
        vim.notify('Cargo workspace reloaded')
      end,
    })
  end,
})
