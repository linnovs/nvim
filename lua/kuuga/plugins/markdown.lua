return {
	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = ":call mkdp#util#install()",
	},

	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown", "codecompanion" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim", -- for icon providewr
		},
		---@module 'markview'
		---@type markview.config
		opts = {
			preview = {
				filetypes = { "markdown", "codecompanion" },
				icon_provider = "mini",
			},
		},
		config = function(_, opts)
			local presets = require("markview.presets")

			---@type markview.config
			local override = {
				markdown = {
					headings = presets.headings.glow,
					horizontal_rules = presets.horizontal_rules.thin,
					tables = presets.tables.rounded,
				},
			}

			opts = vim.tbl_deep_extend("force", opts, override)
			require("markview").setup(opts)
			require("markview.extras.editor").setup()
		end,
	},
}
