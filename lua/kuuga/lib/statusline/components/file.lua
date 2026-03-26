local colors = require("tokyonight.colors").setup() or {}

local M = {}

M.icon = {
	"filetype",
	colored = true,
	icon_only = true,
	padding = { left = 1, right = 0 },
}

M.type = {
	"bo:filetype",
	color = { fg = colors.fg, bg = colors.bg_highlight },
	separator = { left = "", right = "" },
	draw_empty = true,
}

M.name = {
	"filename",
	file_status = true,
	newfile_status = true,
	path = 0,
	symbols = {
		modified = " ",
		readonly = "󰌾 ",
		unnamed = "󰡯 ",
		newfile = "󰎔 ",
	},
	color = { fg = colors.fg },
}

M.format = {
	"fileformat",
	symbols = {
		unix = "",
		dos = "",
		mac = "",
	},
	color = { fg = colors.fg, bg = colors.bg_highlight },
	separator = { left = "" },
}

M.encoding = {
	"encoding",
	color = { fg = colors.fg, bg = colors.bg_highlight },
	separator = { right = "" },
}

return M
