return {
	"MeanderingProgrammer/render-markdown.nvim",
	lazy = true, -- Recommended false
	ft = { "markdown", "quarto" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"echasnovski/mini.icons",
	},
	opts = {
		completions = { blink = { enabled = true } },
		heading = {
			enabled = false,
		},
	},
}
