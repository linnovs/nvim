local nut_buf_diagnostic = require("nougat.nut.buf.diagnostic_count")
local sep = require("nougat.separator")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local diagnostic = function(severity, opts)
	local colors = {
		[vim.diagnostic.severity.ERROR] = color.red,
		[vim.diagnostic.severity.WARN] = color.yellow,
		[vim.diagnostic.severity.INFO] = color.blue,
		[vim.diagnostic.severity.HINT] = color.green,
	}

	opts = vim.tbl_extend("force", {
		hidden = false,
		hl = { fg = color.surface0, bg = colors[severity] },
		sep_right = sep.left_lower_triangle_solid(true),
		prefix = " ",
		suffix = " ",
		config = {
			severity = severity,
		},
	}, opts or {})

	return nut_buf_diagnostic.create(opts)
end

return diagnostic
