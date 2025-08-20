local colors = require("catppuccin.palettes").get_palette("macchiato") or {}
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
	color = { bg = colors.surface2, gui = "bold" },
	separator = { left = "", right = "" },
	draw_empty = false,
}
