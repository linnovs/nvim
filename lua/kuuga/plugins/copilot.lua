return {
	{
		"folke/sidekick.nvim",
		opts = {
			cli = { mux = { enabled = true } },
		},
		keys = {
			{
				"<leader>aa",
				function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end,
				desc = "Toggle sidekick (opencode)",
			},
			{
				"<leader>at",
				function() require("sidekick.cli").send({ msg = "{this}" }) end,
				mode = { "x", "n" },
				desc = "Send this",
			},
			{
				"<leader>af",
				function() require("sidekick.cli").send({ msg = "{file}" }) end,
				desc = "Send file",
			},
			{
				"<leader>av",
				function() require("sidekick.cli").send({ msg = "{selection}" }) end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>ap",
				function() require("sidekick.cli").prompt() end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
		},
	},
}
