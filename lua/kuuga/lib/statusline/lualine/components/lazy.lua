local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = require("lazy.status").updates
M.cond = require("lazy.status").has_updates

M.color = {
	fg = colors.peach,
	bg = colors.overlay0,
}

M.separator = {
	left = "",
	right = "",
}

return M
