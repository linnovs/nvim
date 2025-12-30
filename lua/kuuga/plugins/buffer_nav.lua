return {
	{
		"mistweaverco/bafa.nvim",
		keys = {
			{
				"<leader>s",
				function()
					require("bafa.ui").toggle({
						with_jump_labels = true,
					})
				end,
				desc = "Buffer navigation with bafa.nvim",
			},
		},
		opts = {},
	},
}
