return {
	{
		"rest-nvim/rest.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = "http",
		keys = {
			{ "<leader>rr", "<Plug>RestNvim<CR>", desc = "Run request under cursor", ft = "http" },
		},
		opts = {},
	},
}
