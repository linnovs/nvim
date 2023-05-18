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
			custom_highlights = function(colors)
				return {
					TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
					TelescopePromptPrefix = { bg = colors.surface0 },
					TelescopePromptNormal = { bg = colors.surface0 },
					TelescopeResultsNormal = { bg = colors.mantle },
					TelescopePreviewNormal = { bg = colors.base },
					TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
					TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
					TelescopePreviewBorder = { bg = colors.base, fg = colors.base },
					TelescopePromptTitle = { bg = colors.mauve, fg = colors.mantle },
					TelescopeResultsTitle = { fg = colors.mantle },
					TelescopePreviewTitle = { bg = colors.sapphire, fg = colors.mantle },
					KuugaLogo = { fg = colors.mauve },
				}
			end,
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
