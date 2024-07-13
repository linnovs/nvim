return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = "cd app && yarn install",
	},

	{
		"OXY2DEV/markview.nvim",
		ft = "markdown",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons", -- Used by the code bloxks
		},
		opts = {
			options = {
				on_enable = {
					conceallevel = 2,
					concealcursor = "",
				},
				on_disable = {
					conceallevel = 0,
					concealcursor = "",
				},
			},
		},
	},

	-- {
	-- 	"lukas-reineke/headlines.nvim",
	-- 	ft = "markdown",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	config = true,
	-- },
}
