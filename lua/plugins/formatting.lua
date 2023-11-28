return {
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		opts = {
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports", "golines" },
				zsh = { "beautysh" },
				bash = { "beautysh" },
				sh = { "beautysh" },
			},
			notify_on_error = true,
		},
	},
}
