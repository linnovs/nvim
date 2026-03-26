local colors = require("tokyonight.colors").setup() or {}
local icons = require("kuuga.lib.icons")

return {
	"diagnostics",
	sources = { "nvim_diagnostic", "nvim_workspace_diagnostic" },
	sections = { "error", "warn", "info", "hint" },
	symbols = icons.diagnostics,
	always_visible = false,
	diagnostics_color = {
		error = { fg = colors.red },
		warn = { fg = colors.yellow },
		info = { fg = colors.blue },
		hint = { fg = colors.green },
	},
	color = { bg = colors.bg_highlight, gui = "bold" },
	separator = { left = "", right = "" },
	draw_empty = false,
}
