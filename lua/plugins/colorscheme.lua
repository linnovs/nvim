return {
	{
		"catppuccin/nvim",
		version = false,
		lazy = false,
		priority = 1000,
		name = "catppuccin",
		opts = {
			flavor = "macchiato",
			transparent_background = true,
			-- custom_highlights = function(colors)
			-- 	return {}
			-- end,
			integrations = {
				alpha = true,
				cmp = true,
				gitsigns = true,
				leap = true,
				lsp_trouble = true,
				mason = true,
				neotree = true,
				noice = true,
				notify = true,
				nvimtree = false,
				octo = true,
				telescope = true,
				treesitter = true,
				which_key = true,
				indent_blankline = {
					enabled = true,
				},
				native_lsp = {
					enabled = true,
				},
			},
		},
	},
}
