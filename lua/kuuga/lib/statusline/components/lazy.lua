local colors = require("tokyonight.colors").setup() or {}

return {
	require("lazy.status").updates,
	cond = require("lazy.status").has_updates,
	color = {
		fg = colors.magenta,
		bg = colors.bg_highlight,
	},
	separator = {
		left = "",
		right = "",
	},
}
