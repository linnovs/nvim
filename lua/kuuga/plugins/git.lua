return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufNew",
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
			on_attach = function()
				local gs = package.loaded["gitsigns"]
				local map = require("kuuga.lib.keymap")

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
			graph_style = "unicode",
			disable_commit_confirmation = true,
			use_telescope = true,
		},
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
}
