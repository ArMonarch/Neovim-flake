return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    dashboard = { enabled = false },
    explorer = { enabled = true },
    git = { enabled = true },
    indent = { enabled = true },
    input = { enabled = false },
    lazygit = { enabled = true },
    picker = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    toggle = { enabled = true },
    util = { enabled = false },
    words = { enabled = false }
  },
  -- stylua: ignore
  keys = {
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    -- Explorer Keymaps
    { "<leader>e", function() Snacks.explorer({ cwd = Snacks.git.get_root() }) end, desc = "Explorer Snacks (root dir)"},
    { "<leader>E", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)"},
    { "<leader>fe", function() Snacks.explorer({ cwd = Snacks.git.get_root() }) end, desc = "Explorer Snacks (root dir)"},
    { "<leader>fE", function() Snacks.explorer() end, desc = "Explorer Snacks (cwd)"},
  },
}
