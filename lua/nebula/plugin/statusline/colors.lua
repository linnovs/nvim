local colors = require("nebula.colors")

local M = {}

M.default = {
	fg = colors.basic.fg,
	bg = colors.basic.alt_bg,

	vi_fg = colors.basic.bg_highlight,

	file_fg = colors.basic.fg,
	file_bg = colors.basic.alt_bg,

	lsp_fg = colors.basic.ligth_blue,
	lsp_bg = colors.basic.black,

	diagnostic_fg = colors.basic.ligth_blue,
	diagnostic_bg = colors.basic.black,
	diagnostic_error = colors.lsp.error,
	diagnostic_warning = colors.lsp.warning,
	diagnostic_info = colors.lsp.information,
	diagnostic_hint = colors.lsp.hint,

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
