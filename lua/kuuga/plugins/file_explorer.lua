return {
	"stevearc/oil.nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons", version = false },
	keys = {
		{ "<Leader>of", "<CMD>Oil<CR>", desc = "Open oil (file explorer)" },
	},
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		default_file_explorer = true,
		keymaps = {
			["<leader>wv"] = "actions.select_vsplit",
			["<C-s>"] = false,
		},
	},
}
