return {
	"glepnir/dashboard-nvim",
	event = "VimEnter",
	config = function()
		local dashboard = require("kuuga.lib.dashboard")
		require("dashboard").setup(dashboard)
	end,
}
