return {
	"nanozuki/tabby.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "tabby"
	---@type TabbyConfig
	opts = {
		preset = "active_wins_at_tail",
		option = {
			nerdfont = true,
			lualine_theme = "catppuccin-mocha",
		},
	},
}
