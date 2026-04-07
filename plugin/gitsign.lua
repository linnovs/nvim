vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
		require("gitsigns").setup({
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

				keymap("n", "]h", gs.next_hunk, "Next hunk")
				keymap("n", "[h", gs.prev_hunk, "Prev hunk")

				-- Actions
				keymap("n", "<leader>ghs", gs.stage_hunk, "Stage hunk")
				keymap("n", "<leader>ghr", gs.reset_hunk, "Reset hunk")

				keymap(
					"v",
					"<leader>ghs",
					function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					"Stage selected hunk"
				)
				keymap(
					"v",
					"<leader>ghr",
					function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
					"Reset selected hunk"
				)

				keymap("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
				keymap("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
				keymap("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")

				keymap("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
				keymap("n", "<leader>ghd", gs.diffthis, "Diff this")
				keymap("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff this ~")

				-- Text objects
				keymap({ "o", "x" }, "ih", gs.select_hunk, "Select Hunk")
			end,
		})
	end,
})
