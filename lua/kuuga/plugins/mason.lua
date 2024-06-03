local tools = require("kuuga.lib.tools")

return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = true,
		build = ":MasonUpdate",
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		opts = {
			ensure_installed = tools.to_install(),
			auto_update = false,
			run_on_start = true,
			start_delay = 0,
			debounce_hours = nil,
		},
	},
}
