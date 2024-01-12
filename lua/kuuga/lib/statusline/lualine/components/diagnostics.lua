local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

local function diagnostics(severity, color)
	return {
		"diagnostics",
		source = { "nvim_lsp" },
		sections = { severity },
		symbols = { [severity] = "" },
		always_visible = false,
		diagnostics_color = { [severity] = { fg = colors.surface0 } },
		color = { bg = color },
		separator = { left = "", right = "" },
		draw_empty = true,
	}
end

M.error = diagnostics("error", colors.red)
M.warn = diagnostics("warn", colors.yellow)
M.info = diagnostics("info", colors.blue)
M.hint = diagnostics("hint", colors.green)

return M
