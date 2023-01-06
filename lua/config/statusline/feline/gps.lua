local gps = require("nvim-gps")

return {
	provider = gps.get_location,
	enabled = gps.is_available,
	hl = {
		fg = "gps_fg",
		bg = "gps_bg",
	},
}
