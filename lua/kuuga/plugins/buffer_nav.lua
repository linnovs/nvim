return {
	"leath-dub/snipe.nvim",
	branch = "snipe2",
	keys = {
		{
			"<leader>s",
			function()
				require("snipe").open_buffer_menu()
			end,
			desc = "Open Snipe buffer menu",
		},
	},
	opts = {
		ui = {
			open_win_override = {
				border = "rounded",
			},
		},
		hints = {
			dictionary = "arstgmneiowuy",
		},
		navigate = {
			close_buffer = "<C-d>",
			open_vsplit = "<C-v>",
			open_split = "S",
		},
	},
}
