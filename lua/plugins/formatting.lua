return {
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		opts = {
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "gofmt", "goimports", "golines" },
			},
			notify_on_error = true,
		},
	},
}
