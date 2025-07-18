if nixCats("formatters") then
	return {
		"stevearc/conform.nvim",
		lazy = false,
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
				end,
				mode = { "n", "v" },
				desc = "Format Injected Langs",
			},
		},
		opts = {
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = {
				lsp_format = "fallback",
				timeout_ms = 500,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				sh = { "shfmt" },
				python = { "ruff" },
				rust = { "rustfmt", lsp_format = "fallback" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
			},
		},
	}
else
	return {}
end
