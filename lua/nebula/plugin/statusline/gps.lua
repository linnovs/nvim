local gps = require("nvim-gps")

return {
	provider = function()
		return gps.get_location()
	end,
	enable = gps.is_available,
	hl = {
		fg = "gps_fg",
		bg = "gps_bg",
	},
}
