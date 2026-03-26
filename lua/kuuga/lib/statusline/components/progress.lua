local colors = require("tokyonight.colors").setup() or {}

return {
	"progress",
	color = { fg = colors.fg, bg = colors.teal },
	separator = { left = "" },
}
