return {
	{ "b0o/schemastore.nvim", version = false, lazy = true },

	{
		"neovim/nvim-lspconfig",
		event = "BufReadPost",
		version = false,
		dependencies = {
			"saghen/blink.cmp",
			{
				"folke/lazydev.nvim",
				version = false,
				ft = "lua",
				opts = {
					library = {
						{ path = "snacks.nvim", words = { "Snacks" } },
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
		keys = {
			{
				"<leader>xx",
				"<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
				desc = "Toggle Trouble (buffer diagnostics)",
			},
			{
				"<leader>xX",
				"<CMD>Trouble diagnostics toggle<CR>",
				desc = "Toggle Trouble (Workspace diagnostics)",
			},
		},
	},
}
