local M = {}

local sep = {
	str = " ",
	hl = { bg = "diagnostic_bg" },
}

M.errors = {
	provider = "diagnostic_errors",
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
	hl = {
		fg = "diagnostic_info",
		bg = "diagnostic_bg",
	},
	icon = " ",
	left_sep = sep,
	right_sep = sep,
}

return M
