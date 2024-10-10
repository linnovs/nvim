return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
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
				local keymap = require("kuuga.lib.keymap")

				keymap.map("n", "]h", gs.next_hunk, "Next hunk")
				keymap.map("n", "[h", gs.prev_hunk, "Prev hunk")

				-- Actions
				keymap.map({ "n", "v" }, "<leader>ghs", "<CMD>Gitsigns stage_hunk<CR>", "Stage hunk")
				keymap.map({ "n", "v" }, "<leader>ghr", "<CMD>Gitsigns reset_hunk<CR>", "Reset hunk")
				keymap.map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				keymap.map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
				keymap.map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				keymap.map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
				keymap.map("n", "<leader>ghb", function()
					gs.blame_line({ full = true })
				end, "Blame Line")
				keymap.map("n", "<leader>ghd", gs.diffthis, "Diff this")
				keymap.map("n", "<leader>ghD", function()
					gs.map.diffthis("~")
				end, ".mapDiff this ~")

				-- Tex.mapt objects
				keymap.map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk()<CR>", "GitSigns Select Hunk")
			end,
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
