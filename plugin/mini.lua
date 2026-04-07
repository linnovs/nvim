vim.schedule(function()
	vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim", version = vim.version.range("*") } })

	require("kuuga.lib.keymap")("n", "<Leader>gc", function() vim.cmd("Git commit") end, "Git commit")

	require("mini.bracketed").setup()
	require("mini.pairs").setup({
		modes = { insert = true, command = false, terminal = true },
		mappings = {
			["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
			["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
			["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

			[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
			["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
			["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

			['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
			["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
			["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
		},
	})
	require("mini.surround").setup({
		mappings = {
			add = "ys",
			delete = "ds",
			find = "gsf",
			find_left = "gsF",
			highlight = "gsh",
			replace = "cs",
			update_n_lines = "gsn",
		},
	})
	require("mini.comment").setup({
		options = {
			custom_commentstring = function()
				local ok, module = pcall(require, "ts_context_commentstring")
				return ok and module.calculate_commentstring() or vim.bo.commentstring
			end,
		},
		mappings = {
			comment = "gc",
			comment_line = "gcc",
			comment_visual = "gc",
			textobject = "gc",
		},
	})
	require("mini.git").setup()
end)
