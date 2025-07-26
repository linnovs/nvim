return {
	"nanozuki/tabby.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	---@module "tabby"
	---@type TabbyConfig
	opts = {
		preset = "tab_only",
		option = {
			nerdfont = true,
			lualine_theme = "catppuccin",
		},
	},
}
