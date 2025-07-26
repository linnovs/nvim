return {
	"nanozuki/tabby.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "tabby"
	---@type TabbyConfig
	opts = {
		preset = "active_wins_at_tail",
		option = {
			nerdfont = true,
			lualine_theme = "catppuccin",
		},
	},
}
