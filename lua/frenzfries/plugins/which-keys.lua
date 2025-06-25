return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts_extend = { 'spec' },
  opts = {
    preset = 'helix',
    default = {},
    spec = {
      {
        mode = { "n", "v" },
        { "<leader><tab>", group = "tabs" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>dp", group = "profiler" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>gh", group = "hunks" },
        { "<leader>s", group = "search" },
        { "<leader>q", group = "quit/session" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
        { "gs", group = "surround" },
        { "z", group = "fold" },
        { "<leader>b", group = "buffer", expand = function() return require("which-key.extras").expand.buf() end, },
        { "<leader>w", group = "windows", proxy = "<c-w>", expand = function() return require("which-key.extras").expand.win() end, },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },

  keys = {
    -- { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
    { "<c-w><space>", function() require("which-key").show({ keys = {"<c-w>"}, loop = true }) end, desc = "Buffer Keymaps (which-key)" },
  },

  -- config = function(_, opts)
  --   local wk = require('which-key')
  --   wk.setup()
  --   if not vim.tbl_isempty(opts.defaults) then
  --     -- FIX: add the LazyVim.warn function insted of lua print()
  --     -- LazyVim.warn("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
  --     print("which-key: opts.defaults is deprecated. Please use opts.spec instead.")
  --     wl.register(opts.defaults)
  --   end
  -- end,
}
