return {
	"wakatime/vim-wakatime",

	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				css = true,
				tailwind = "lsp",
			},
		},
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
				map({ "n", "v" }, "<leader>ghs", "<CMD>Gitsigns stage_hunk<CR>", "Stage hunk")
				map({ "n", "v" }, "<leader>ghr", "<CMD>Gitsigns reset_hunk<CR>", "Reset hunk")
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
				["<leader>ze"] = { name = "+zen" },
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
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		init = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
		keys = {
			{
				"zR",
				'<CMD>lua require("ufo").openAllFold()<CR>',
				desc = "Open all folds (ufo version)",
			},
			{
				"zM",
				'<CMD>lua require("ufo").closeAllFold()<CR>',
				desc = "Close all folds (ufo version)",
			},
		},
		opts = {},
	},

	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},

	{ "davidgranstrom/nvim-markdown-preview", cmd = { "MarkdownPreview" } },
}
