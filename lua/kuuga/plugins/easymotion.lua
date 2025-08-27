return {
	"folke/flash.nvim",
	event = "BufReadPost",
	---@type Flash.Config
	opts = {
		labels = "arstgmneioqwfpbjluyzxcdvkh",
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function() require("flash").jump() end,
			desc = "Flash",
		},
		{
			"S",
			mode = { "n", "o", "x" },
			function() require("flash").treesitter() end,
			desc = "Flash Treesitter",
		},
		{
			"r",
			mode = "o",
			function() require("flash").remote() end,
			desc = "Remote Flash",
		},
		{
			"R",
			mode = { "o", "x" },
			function() require("flash").treesitter_search() end,
			desc = "Treesitter Search",
		},
		{
			"<c-s>",
			mode = { "c" },
			function()
				local state = require("flash").toggle()
				vim.notify(
					"Toggle Flash Search " .. (state and "ON" or "OFF"),
					vim.log.levels.INFO,
					{ title = "Flash", id = "toggle-flash" }
				)
			end,
			desc = "Toggle Flash Search",
		},
	},
}
