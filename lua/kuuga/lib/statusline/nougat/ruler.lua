local Item = require("nougat.item")
local core = require("nougat.core")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local ruler = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.overlay0, fg = color.teal },
		prefix = "  ",
		content = core.group({
			core.code("3.l"),
			":",
			core.code("-3.c"),
		}),
		suffix = " ",
	}, opts or {})

	return Item(opts)
end

return ruler
