return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		version = false,
		build = ":TSUpdate",
		event = "BufReadPost",
		opts = {
			sync_install = false,
			ensure_installed = "all",
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true },
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
