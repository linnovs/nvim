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

M.vi_mode = {
	["NORMAL"] = colors.basic.blue,
	["OP"] = colors.basic.blue,
	["MORE"] = colors.basic.blue,
	["ENTER"] = colors.basic.blue,
	["CONFIRM"] = colors.basic.blue,
	["NONE"] = colors.basic.blue,
	["INSERT"] = colors.basic.green,
	["VISUAL"] = colors.basic.magenta,
	["BLOCK"] = colors.basic.magenta,
	["LINES"] = colors.basic.magenta,
	["SELECT"] = colors.basic.magenta,
	["REPLACE"] = colors.basic.red,
	["V-REPLACE"] = colors.basic.red,
	["COMMAND"] = colors.basic.yellow,
	["SHELL"] = colors.basic.yellow,
	["TERM"] = colors.basic.yellow,
}

return M
