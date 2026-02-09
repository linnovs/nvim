local colors = require("catppuccin.palettes").get_palette("mocha") or {}

return {
	"selectioncount",
	icon = "",
	color = { fg = colors.teal, bg = colors.overlay0 },
	padding = { left = 0, right = 1 },
}
