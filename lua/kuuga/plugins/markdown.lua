return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},

	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- Used by the code bloxks
		},
		opts = {
			modes = { "n", "no", "c" },

			hybrid_modes = { "n" },

			callbacks = {
				on_enable = function(_, win)
					vim.wo[win].conceallevel = 2
					---@diagnostic disable-next-line: inject-field
					vim.wo[win].conecalcursor = "c"
				end,
			},
		},
	},
}
