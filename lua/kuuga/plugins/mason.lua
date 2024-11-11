local tools = require("kuuga.lib.tools")

return {
	{
		"williamboman/mason.nvim",
		lazy = true,
		config = true,
		build = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
			},
		},
	},

	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		event = "VeryLazy",
		dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		init = function()
			-- this is required to run the mason-tool-installer's run_on_start when lazyload is on, since the
			-- plugin is using VimEnter event to start the installer function
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = require("mason-tool-installer").run_on_start,
			})
		end,
		opts = {
			ensure_installed = tools.to_install(),
			run_on_start = true,
			auto_update = true,
		},
	},
}
