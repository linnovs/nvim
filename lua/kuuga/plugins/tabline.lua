return {
	"nanozuki/tabby.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("kuuga.lib.tabline")
	end,
}
