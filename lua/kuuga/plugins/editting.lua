return {
	{
		"echasnovski/mini.comment",
		event = "BufReadPost",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
			mappings = {
				comment = "gc",
				comment_line = "gcc",
				comment_visual = "gc",
				textobject = "gc",
			},
		},
	},

	{
		"echasnovski/mini.surround",
		event = "BufReadPost",
		opts = {
			mappings = {
				add = "ys",
				delete = "ds",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "cs",
				update_n_lines = "gsn",
			},
		},
	},

	{
		"echasnovski/mini.ai",
		event = "BufReadPost",
		opts = {
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
		},
	},

	{
		"echasnovski/mini.pairs",
		event = "BufReadPost",
		opts = {
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
		},
	},

	{
		"echasnovski/mini.bracketed",
		event = "BufReadPost",
		opts = {},
	},
}
