return {
  'sphamba/smear-cursor.nvim',
  event = "VeryLazy",
  cond = vim.g.neovide == nil,
  opts = {
    hide_target_hack = true,
    cursor_color = 'none',
  },
  specs = {
    -- NOTE: disable mini.animate cursor if installed
    -- as of now mini.animate is not installed
  },
}
