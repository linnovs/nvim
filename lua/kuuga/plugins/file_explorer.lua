return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	keys = {
		{ "<Leader>of", "<CMD>Oil<CR>", desc = "Open oil (file explorer)" },
	},
	opts = {
		keymaps = {
			["<leader>wv"] = "actions.select_vsplit",
			["<C-s>"] = false,
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons", version = false },
}
