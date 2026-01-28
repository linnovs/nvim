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
		---@module 'bafa.Config'
		---@type BafaUserConfig
		opts = {
			ui = {
				jump_labels = {
					-- stylua: ignore start
					keys = {
						"a", "r", "s", "t", "n", "e", "i", "o", -- home row
						"q", "w", "f", "p", "l", "u", "y", ";", -- top row
						"z", "x", "c", "k", "h", ",", ".",      -- bottom row
					},
					-- stylua: ignore end
				},
			},
		},
	},
}
