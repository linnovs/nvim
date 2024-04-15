return {
	"utilyre/barbecue.nvim",
	event = "BufNew",
	name = "barbecue",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		attach_navic = false,
		theme = "catppucin-macchiato",
		exclude_filetypes = { "netwr", "oil", "toggleterm" },
	},
}
