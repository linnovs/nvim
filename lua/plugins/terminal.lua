return {
	{
		"akinsho/nvim-toggleterm.lua",
		version = "*",
		event = "VeryLazy",
		opts = {
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<Leader>tt]],
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = true,
			persist_size = true,
			persist_mode = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
			auto_scroll = true,
			winbar = {
				enabled = true,
			},
		},
	},
}
