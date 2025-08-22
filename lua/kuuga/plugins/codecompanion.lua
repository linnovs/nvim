return {
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			"ravitemer/codecompanion-history.nvim",
			"Davidyz/VectorCode",
		},
		cmd = {
			"CodeCompanion",
			"CodeCompanionChat",
			"CodeCompanionCmd",
			"CodeCompanionActions",
			"CodeCompanionHistory",
			"CodeCompanionSummaries",
		},
		opts = function()
			return {
				display = {
					action_palette = {
						provider = "snacks",
					},
				},
				strategies = {
					chat = {
						adapter = {
							name = "copilot",
							model = "gpt-5-mini",
						},
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
				extensions = {
					history = {
						enabled = true,
						---@module "codecompanion/_extensions/history"
						---@type CodeCompanion.History.Opts
						opts = {
							picker = "snacks",
							delete_on_clearing_chat = true,
						},
					},
					---@module "vectorcode"
					vectorcode = {
						enabled = true,
						---@type VectorCode.CodeCompanion.ExtensionOpts
						opts = {},
					},
				},
			}
		end,
		keys = {
			{
				"<leader>cc",
				"<CMD>CodeCompanionActions<CR>",
				desc = "Code Companion Actions",
			},
		},
	},

	{
		"Davidyz/VectorCode",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "VectorCode",
	},
}
