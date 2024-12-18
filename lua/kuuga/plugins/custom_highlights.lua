return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoFzfLua" },
		event = "BufReadPost",
		keys = {
			{ "<leader>ft", "<cmd>TodoFzfLua<CR>", desc = "Find TODOs" },
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
		event = "BufReadPost",
		opts = true,
	},
}
