return {
	"gpanders/editorconfig.nvim",
	"wakatime/vim-wakatime",
	{ "norcalli/nvim-colorizer.lua", config = true },

	{
		"nvim-telescope/telescope.nvim",
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
				"<leader>fs",
				"<CMD>Telescope lsp_document_symbols<CR>",
				desc = "Find LSP document symblos",
			},
		},
		opts = function()
			local actions = require("telescope.actions")
			return {
				defaults = {
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
						theme = "dropdown",
						hidden = true,
						follow = true,
					},
					live_grep = {
						theme = "dropdown",
					},
					buffers = {
						theme = "dropdown",
					},
					help_tags = {
						theme = "dropdown",
					},
					zoxide = {
						theme = "dropdown",
					},
				},
			}
		end,
	},

	{
		"jvgrootveld/telescope-zoxide",
		dependencies = { "nvim-telescope/telescope.nvim" },
		keys = {
			{
				"<leader>z",
				"<CMD>Telescope zoxide list<CR>",
				desc = "Find zoxide directory",
			},
		},
		config = function()
			require("telescope._extensions.zoxide.config").setup({

				mappings = {
					default = {
						after_action = function(selection)
							vim.notify("Directory changed to " .. selection.path)
						end,
					},
				},
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = "TodoTelescope",
		event = "BufReadPost",
		keys = {
			{ "<leader>todo", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
		},
		config = true,
	},

	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded["gitsigns"]
				local function map(mode, lhs, rhs, desc)
					vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
				end

				map("n", "]h", gs.next_hunk, "Next hunk")
				map("n", "[h", gs.prev_hunk, "Prev hunk")

				-- Actions
				map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
				map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
				map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				map("n", "<leader>ghd", gs.diffthis, "Diff this")
				map("n", "<leader>ghD", function()
					gs.diffthis("~")
				end, "Diff this ~")

				-- Text objects
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk()<CR>", "GitSigns Select Hunk")
			end,
		},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		keys = {
			{
				"<leader>op",
				function()
					require("neo-tree.command").execute({ toggle = true })
				end,
				desc = "Toggle Explorer",
			},
		},
		init = function()
			vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		end,
		opts = {
			default_component_configs = {
				icon = {
					folder_empty = " ",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						-- auto close
						require("neo-tree").close_all()
					end,
				},
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			key_labels = { ["<leader>"] = "SPC" },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			})
		end,
	},

	{
		"folke/trouble.nvim",
		cmd = { "Trouble", "TroubleToggle" },
		opts = { use_diagnostic_signs = true },
		keys = {
			{
				"<leader>xx",
				"<CMD>TroubleToggle document_diagnostics<CR>",
				desc = "Toggle Trouble (Document diagnostics)",
			},
			{
				"<leader>xX",
				"<CMD>TroubleToggle workspace_diagnostics<CR>",
				desc = "Toggle Trouble (Workspace diagnostics)",
			},
		},
	},

	{
		"pwntester/octo.nvim",
		cmd = { "Octo" },
		opts = {
			mappings = {
				submit_win = {
					approve_review = { lhs = "<leader>ar", desc = "approve review" },
					comment_review = { lhs = "<leader>cr", desc = "comment review" },
					request_changes = { lhs = "<leader>rc", desc = "request changes review" },
					close_review_tab = { lhs = "<leader>x", desc = "close review tab" },
				},
			},
		},
	},

	{ "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" } },
}
