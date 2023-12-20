local formatters = require("kuuga.lib.tools").formatters

return {
	{
		"stevearc/conform.nvim",
		event = "BufReadPre",
		cmd = "ConformInfo",
		init = function()
			vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
		end,
		opts = {
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
			formatters_by_ft = formatters,
			notify_on_error = true,
		},
	},
}
