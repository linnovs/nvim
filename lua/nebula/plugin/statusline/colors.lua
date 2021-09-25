local colors = require("nebula.colors")

local M = {}

M.default = {
	fg = colors.basic.fg,
	bg = colors.basic.alt_bg,

	vi_fg = colors.basic.bg_highlight,

	file_fg = colors.basic.fg,
	file_bg = colors.basic.alt_bg,

	git_fg = colors.basic.orange,
	git_bg = colors.basic.black,
	git_added = colors.git.added,
	git_modified = colors.git.modified,
	git_removed = colors.git.modified,
}

return M
