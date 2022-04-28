local M = {}

M.branch = {
	provider = "git_branch",
	hl = {
		fg = "git_fg",
		bg = "git_bg",
	},
	left_sep = {
		str = " ",
		hl = { bg = "git_bg" },
	},
}

M.added = {
	provider = "git_diff_added",
	hl = {
		fg = "git_added",
		bg = "git_bg",
	},
	icon = "  ",
}

M.modified = {
	provider = "git_diff_changed",
	hl = {
		fg = "git_modified",
		bg = "git_bg",
	},
	icon = "  ",
}

M.removed = {
	provider = "git_diff_removed",
	hl = {
		fg = "git_removed",
		bg = "git_bg",
	},
	icon = "  ",
}

M.right_sep = {
	provider = " ",
	enabled = require("feline.providers.git").git_info_exists,
	hl = {
		bg = "git_bg",
	},
}

return M
