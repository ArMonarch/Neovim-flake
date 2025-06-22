-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd( 'TextYankPost', {
  desc = 'Highlight when yanking (copying) text | Briefly highlight yanked text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
