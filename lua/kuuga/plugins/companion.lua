return {
	"olimorris/codecompanion.nvim",
	cmd = {
		"CodeCompanion",
		"CodeCompanionChat",
		"CodeCompanionCmd",
		"CodeCompanionActions",
	},
	opts = {
		display = {
			action_palette = {
				provider = "snacks",
			},
		},
		strategies = {
			chat = {
				slash_commands = {
					["buffer"] = { opts = { provider = "snacks" } },
					["fetch"] = { opts = { provider = "snacks" } },
					["file"] = { opts = { provider = "snacks" } },
					["help"] = { opts = { provider = "snacks" } },
					["image"] = { opts = { provider = "snacks" } },
					["symbols"] = { opts = { provider = "snacks" } },
				},
			},
		},
	},
	keys = {
		{
			"<leader>cc",
			"<CMD>CodeCompanionActions<CR>",
			desc = "Code Companion Actions",
		},
	},
}
