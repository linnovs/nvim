vim.schedule(function()
	vim.pack.add({ { src = "https://github.com/echasnovski/mini.nvim", version = vim.version.range("*") } })
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "Trouble", "help", "mason", "man", "dashboard" },
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})

	require("kuuga.lib.keymap")("n", "<Leader>gc", function()
		vim.cmd("Git commit")
	end, "Git commit")

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
	require("mini.ai").setup({
		custom_textobjects = nil,

		mappings = {
			around = "a",
			inside = "i",

			around_next = "an",
			inside_next = "in",
			around_last = "al",
			inside_last = "il",

			goto_left = "g[",
			goto_right = "g]",
		},

		n_lines = 500,
		search_method = "cover_or_next",

		silent = false,
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
				return require("ts_context_commentstring").calculate_commentstring() or vim.bo.commentstring
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
