local formatters = require("kuuga.lib.tools").formatters

return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = "ConformInfo",
	init = function()
		vim.o.formatexpr = "v:lua.require('conform').formatexpr()"
	end,
	opts = {
		format_on_save = function(bufnr)
			-- Disable with a global or buffer-local variable
			if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
				return
			end
			return { timeout_ms = 500, lsp_format = "fallback" }
		end,
		formatters_by_ft = formatters,
		notify_on_error = true,
	},
}
