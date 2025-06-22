return {
  "folke/todo-comments.nvim",
  -- cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufWritePost", "BufNewFile"},
  opts = {},
  -- stylua: ignore
  keys = {
    { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
    { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
  --   TODO: Needed trouble.nvim { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
  --   TODO: Needed trouble.nvim { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
  --   TODO: Needed telescope.nvim { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
  --   TODO: Needed telescope.nvim { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
  },
}