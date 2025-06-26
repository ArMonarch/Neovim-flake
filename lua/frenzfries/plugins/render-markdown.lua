return {
  'MeanderingProgrammer/render-markdown.nvim',
  lazy = false, -- Recommended
  ft = { 'markdown', 'quarto' },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "echasnovski/mini.icons",
  },
  opts = {
    completions = { blink = { enabled = true } },
  },
}
