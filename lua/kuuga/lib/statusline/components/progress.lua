local colors = require("catppuccin.palettes").get_palette("mocha") or {}

return {
	"progress",
	color = { fg = colors.base, bg = colors.teal },
	separator = { left = "" },
}
