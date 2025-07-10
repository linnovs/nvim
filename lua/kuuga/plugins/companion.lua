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
	},
	keys = {
		{
			"<leader>cc",
			"<CMD>CodeCompanionActions<CR>",
			desc = "Code Companion Actions",
		},
	},
}
