return {
	"tamton-aquib/duck.nvim",
	keys = {
		{
			"<leader>dd",
			function()
				require("duck").hatch()
			end,
			desc = "Hatch a duck",
		},
		{
			"<leader>dk",
			function()
				require("duck").cook()
			end,
			desc = "Cook a duck",
		},
	},
}
