return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "jvgrootveld/telescope-zoxide", version = false },
		},
		cmd = "Telescope",
		version = false,
		keys = {
			{
				"<leader><leader>",
				"<CMD>Telescope find_files<CR>",
				desc = "Find files (root dir)",
			},
			{
				"<leader>fg",
				"<CMD>Telescope live_grep<CR>",
				desc = "Find in files (ripgrep)",
			},
			{
				"<leader>fb",
				"<CMD>Telescope buffers<CR>",
				desc = "Find buffers",
			},
			{
				"<leader>fh",
				"<CMD>Telescope help_tags<CR>",
				desc = "Find help tags",
			},
			{
				"<leader>fm",
				"<CMD>Telescope man_pages<CR>",
				desc = "Find man pages",
			},
			{
				"<leader>fs",
				"<CMD>Telescope lsp_document_symbols<CR>",
				desc = "Find LSP document symbols",
			},
			{
				"<leader>fq",
				"<CMD>Telescope quickfix<CR>",
				desc = "Find items in quickfix list",
			},
			{
				"<leader>z",
				"<CMD>Telescope zoxide list<CR>",
				desc = "Find zoxide directory",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local config = require("telescope.config")

			-- Clone the default Telescope configuration
			local vimgrep_arguments = { unpack(config.values.vimgrep_arguments) }

			table.insert(vimgrep_arguments, "--hidden") -- include the hidden files (dot files)
			-- Ignore all file in .git and glob
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")

			local opts = {
				defaults = {
					vimgrep_arguments = vimgrep_arguments,
					layout_config = {
						horizontal = {
							mirror = false,
						},
						vertical = {
							mirror = false,
						},
					},
					set_env = { ["COLORTERM"] = "truecolor" },
					mappings = {
						i = {
							["<ESC>"] = actions.close,
							["<C-h>"] = "which_key",
						},
					},
				},
				pickers = {
					find_files = {
						hidden = true,
						follow = true,
						find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
						layout_config = {
							prompt_position = "top",
						},
					},
					-- live_grep = {
					-- 	theme = "dropdown",
					-- },
					buffers = {
						theme = "dropdown",
						mappings = {
							i = {
								["<C-d>"] = actions.delete_buffer,
							},
						},
					},
					help_tags = {
						theme = "dropdown",
					},
					zoxide = {
						theme = "dropdown",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					zoxide = {
						mappings = {
							default = {
								after_action = function(selection)
									vim.notify("Directory changed to " .. selection.path)
								end,
							},
						},
					},
					["ui-select"] = {},
				},
			}

			telescope.setup(opts)
			telescope.load_extension("zoxide")
			telescope.load_extension("noice")
		end,
	},
}
