local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M.icon = {
	"filetype",
	colored = true,
	icon_only = true,
	padding = { left = 1, right = 0 },
}

M.type = {
	"bo:filetype",
	color = { fg = colors.text, bg = colors.surface0 },
	separator = { left = "", right = "" },
}

M.name = {
	"filename",
	file_status = true,
	newfile_status = true,
	path = 0,
	symbols = {
		modified = "󰏫 ",
		readonly = "󰌾 ",
		unnamed = "󰅪 ",
		newfile = "󰎔 ",
	},
	color = { fg = colors.text },
}

M.format = {
	"fileformat",
	symbols = {
		unix = "",
		dos = "",
		mac = "",
	},
	color = { fg = colors.text, bg = colors.surface1 },
	separator = { left = "" },
}

M.encoding = {
	"encoding",
	color = { fg = colors.text, bg = colors.surface1 },
	separator = { right = "" },
}

return M
