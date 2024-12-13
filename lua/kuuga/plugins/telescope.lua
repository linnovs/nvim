return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "jvgrootveld/telescope-zoxide", version = false },
	},
	cmd = "Telescope",
	keys = {
		{
			"<leader><leader>",
			"<CMD>lua require('telescope.builtin').find_files({})<CR>",
			desc = "Find files (root dir)",
		},
		{
			"<leader>fg",
			"<CMD>lua require('telescope.builtin').live_grep({})<CR>",
			desc = "Find in files (ripgrep)",
		},
		{
			"<leader>fb",
			"<CMD>lua require('telescope.builtin').buffers({})<CR>",
			desc = "Find buffers",
		},
		{
			"<leader>fh",
			"<CMD>lua require('telescope.builtin').help_tags({})<CR>",
			desc = "Find help tags",
		},
		{
			"<leader>fm",
			"<CMD>lua require('telescope.builtin').man_pages({})<CR>",
			desc = "Find man pages",
		},
		{
			"<leader>fs",
			"<CMD>lua require('telescope.builtin').lsp_document_symbols({})<CR>",
			desc = "Find LSP document symbols",
		},
		{
			"<leader>fkm",
			"<CMD>lua require('telescope.builtin').keymaps({})<CR>",
			desc = "Find keymaps",
		},
		{
			"<leader>fq",
			"<CMD>lua require('telescope.builtin').quickfix({})<CR>",
			desc = "Find items in quickfix list",
		},
	},
	config = function()
		require("kuuga.lib.telescope")
	end,
}
