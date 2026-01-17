local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

return {
	require("lazy.status").updates,
	cond = require("lazy.status").has_updates,
	color = {
		fg = colors.peach,
		bg = colors.overlay0,
	},
	separator = {
		left = "",
		right = "",
	},
}
