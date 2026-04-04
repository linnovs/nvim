local icons = { error = " ", warn = " ", info = " ", hint = " " }

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.error,
			[vim.diagnostic.severity.WARN] = icons.warn,
			[vim.diagnostic.severity.INFO] = icons.info,
			[vim.diagnostic.severity.HINT] = icons.hint,
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
