return {
	"gpanders/editorconfig.nvim",
	"wakatime/vim-wakatime",
	{ "NvChad/nvim-colorizer.lua", config = true },

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
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
				"<leader>fs",
				"<CMD>Telescope lsp_document_symbols<CR>",
				desc = "Find LSP document symblos",
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
			local opts = {
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
					zoxide = {
						mappings = {
							default = {
								after_action = function(selection)
									vim.notify("Directory changed to " .. selection.path)
								end,
							},
						},
					},
				},
			}

			telescope.setup(opts)
			telescope.load_extension("zoxide")
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
			current_line_blame = true,
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
			filesystem = {
				follow_current_file = true,
				use_libuv_file_watcher = true,
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
				["<leader>o"] = { name = "+obisdian/explorer" },
				["<leader>l"] = { name = "+lazy" },
				["<leader>t"] = { name = "+terminal/todo" },
			})
		end,
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

	{
		"ggandor/leap.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "ggandor/flit.nvim", opts = { labeled_modes = "nv" } },
			{ "tpope/vim-repeat", version = false },
		},
		config = function()
			require("leap").add_default_mappings()
		end,
	},

	{
		"epwalsh/obsidian.nvim",
		cmd = {
			"ObsidianCheck",
			"ObsidianToday",
			"ObsidianYesterday",
			"ObsidianOpen",
			"ObsidianNew",
			"ObsidianQuickSwitch",
			"ObsidianBacklinks",
			"ObsidianSearch",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianFollowLink",
		},
		keys = {
			{
				"<leader>oo",
				"<CMD>ObsidianQuickSwitch<CR>",
				desc = "Obsidian Quick Switch",
			},
			{
				"<leader>os",
				"<CMD>ObsidianSearch<CR>",
				desc = "Obsidian Search",
			},
			{
				"<leader>on",
				"<CMD>ObsidianNew<CR>",
				desc = "Obsidian New Note",
			},
			{
				"<leader>oa",
				"<CMD>ObsidianOpen<CR>",
				desc = "Open Obsidian App",
			},
			{
				"<leader>ot",
				"<CMD>ObsidianToday<CR>",
				desc = "Create Obsidian Today Note",
			},
			{
				"<leader>oy",
				"<CMD>ObsidianToday<CR>",
				desc = "Create/Open Obsidian Yesterday Note",
			},
		},
		opts = {
			dir = "~/Documents/Obsidian Vault",
			notes_subdir = "notes",
			daily_notes = {
				folder = "notes/dailies",
			},
			-- completion = { nvim_cmp = true },
		},
	},

	{ "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" } },
}
