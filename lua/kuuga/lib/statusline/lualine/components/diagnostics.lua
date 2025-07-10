local colors = require("catppuccin.palettes").get_palette("macchiato") or {}
local icons = require("kuuga.lib.icons")

local M = {}

M[1] = "diagnostics"
M.sources = { "nvim_diagnostic", "nvim_workspace_diagnostic" }
M.sections = { "error", "warn", "info", "hint" }
M.symbols = icons.diagnostics
M.always_visible = false
M.diagnostics_color = {
	error = { fg = colors.red },
	warn = { fg = colors.yellow },
	info = { fg = colors.blue },
	hint = { fg = colors.green },
}
M.color = { bg = colors.surface2, gui = "bold" }
M.separator = { left = "", right = "" }
M.draw_empty = false

return M
