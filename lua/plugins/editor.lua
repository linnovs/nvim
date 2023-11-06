return {
	"wakatime/vim-wakatime",

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufReadPre",
		opts = {
			user_default_options = {
				css = true,
				tailwind = "lsp",
				RRGGBBAA = true,
				AARRGGBB = true,
				rgb_fn = true,
			},
		},
		config = function(_, opts)
			local colorizer = require("colorizer")

			colorizer.setup(opts)

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "lazy", "gitcommit" },
				callback = function(args)
					colorizer.detach_from_buffer(args.buf)
				end,
			})
		end,
	},

	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = "BufReadPost",
		keys = {
			{ "<leader>todo", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
			{
				"]t",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next TODO comment",
			},
			{
				"[t",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous TODO comment",
			},
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
		"NeogitOrg/neogit",
		dependencies = "nvim-lua/plenary.nvim",
		keys = {
			{
				"<leader>gst",
				"<cmd>Neogit<cr>",
				desc = "Toggle neogit",
			},
		},
		opts = {
			disable_commit_confirmation = true,
			use_telescope = true,
		},
	},

	{
		"stevearc/oil.nvim",
		lazy = false,
		keys = {
			{ "<Leader>of", "<CMD>Oil<CR>", desc = "Open oil (file explorer)" },
		},
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
			enable_builtin = true,
			mappings = {
				submit_win = {
					approve_review = { lhs = "<leader>ar", desc = "approve review" },
					comment_review = { lhs = "<leader>cr", desc = "comment review" },
					request_changes = { lhs = "<leader>rc", desc = "request changes review" },
					close_review_tab = { lhs = "<leader>qq", desc = "close review tab" },
				},
			},
		},
	},

	{
		"folke/flash.nvim",
		event = "BufReadPre",
		opts = {},
        -- stylua: ignore
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash", },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
		},
	},

	{
		"RRethy/vim-illuminate",
		event = "BufReadPre",
		opts = {
			delay = 200,
			large_file_cutoff = 2000,
			large_file_overrides = {
				providers = { "lsp" },
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
			end

			map("]]", "next")
			map("[[", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]]", "next", buffer)
					map("[[", "prev", buffer)
				end,
			})
		end,
		keys = {
			{ "]]", desc = "Next Reference" },
			{ "[[", desc = "Prev Reference" },
		},
	},

	{
		"kevinhwang91/nvim-ufo",
		event = "BufRead",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		init = function()
			vim.o.foldcolumn = "0"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
		end,
        -- stylua: ignore
		keys = {
			{ "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds (ufo version)", },
			{ "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds (ufo version)", },
		},
		opts = {},
	},

	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
	},

	{
		"iamcco/markdown-preview.nvim",
		ft = "markdown",
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
}
