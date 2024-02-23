return {
	"stevearc/oil.nvim",
	lazy = false,
	keys = {
		{ "<Leader>of", "<CMD>Oil<CR>", desc = "Open oil (file explorer)" },
	},
	opts = {
		keymaps = {
			["<leader>wv"] = "actions.select_vsplit",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
