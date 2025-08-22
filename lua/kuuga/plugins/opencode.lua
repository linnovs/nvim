return {
	{
		"NickvanDyke/opencode.nvim",
		dependencies = { "folke/snacks.nvim" },
		opts = {
			on_opencode_not_found = function() end,
		},
		keys = {
			{ "<Leader>opa", function() require("opencode").ask() end, desc = "Ask opencode" },
			{ "<Leader>opn", function() require("opencode").command("session_new") end, desc = "New opencode session" },
		},
	},
}
