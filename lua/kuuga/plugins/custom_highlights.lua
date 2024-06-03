return {
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		keys = {
			{ "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next TODO comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous TODO comment",
			},
		},
		config = true,
	},

	{
		"brenoprata10/nvim-highlight-colors",
		event = "BufRead",
		opts = true,
	},
}
