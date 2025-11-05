return {
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		---@module "gitsigns"
		---@type Gitsigns.Config
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			attach_to_untracked = true,
			current_line_blame = true,
			on_attach = function()
				local gs = package.loaded["gitsigns"]
				local keymap = require("kuuga.lib.keymap")

				keymap.map("n", "]h", gs.next_hunk, "Next hunk")
				keymap.map("n", "[h", gs.prev_hunk, "Prev hunk")

				-- Actions
				keymap.map("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				keymap.map("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")

				keymap.map(
					"v",
					"<leader>ghs",
					function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					"Stage selected hunk"
				)
				keymap.map(
					"v",
					"<leader>ghr",
					function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					"Reset selected hunk"
				)

				keymap.map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				keymap.map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				keymap.map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")

				keymap.map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				keymap.map("n", "<leader>ghd", gs.diffthis, "Diff this")
				keymap.map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff this ~")

				-- Text objects
				keymap.map({ "o", "x" }, "ih", gs.select_hunk, "Select Hunk")
			end,
		},
	},
}
