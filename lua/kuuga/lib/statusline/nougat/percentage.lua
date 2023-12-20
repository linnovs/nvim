local Item = require("nougat.item")
local core = require("nougat.core")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local percentage = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.teal, fg = color.base },
		prefix = " ",
		content = core.code("3.p"),
		suffix = "%% ",
	}, opts or {})

	return Item(opts)
end

return percentage
