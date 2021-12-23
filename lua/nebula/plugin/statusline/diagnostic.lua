local lsp = require("feline.providers.lsp")
local severity = vim.diagnostic.severity
local M = {}

local sep = {
	str = " ",
	hl = { bg = "diagnostic_bg" },
}

M.errors = {
	provider = "diagnostic_errors",
	enable = lsp.diagnostics_exist(severity.ERROR),
	hl = {
		fg = "diagnostic_error",
		bg = "diagnostic_bg",
	},
	icon = " ",
	left_sep = sep,
	right_sep = sep,
}

M.warnings = {
	provider = "diagnostic_warnings",
	enable = lsp.diagnostics_exist(severity.WARN),
	hl = {
		fg = "diagnostic_warning",
		bg = "diagnostic_bg",
	},
	icon = " ",
	left_sep = sep,
	right_sep = sep,
}

M.hints = {
	provider = "diagnostic_hints",
	enable = lsp.diagnostics_exist(severity.HINT),
	hl = {
		fg = "diagnostic_hint",
		bg = "diagnostic_bg",
	},
	icon = "",
	left_sep = sep,
	right_sep = sep,
}

M.info = {
	provider = "diagnostic_info",
	enable = lsp.diagnostics_exist(severity.INFO),
	hl = {
		fg = "diagnostic_info",
		bg = "diagnostic_bg",
	},
	icon = " ",
	left_sep = sep,
	right_sep = sep,
}

return M
