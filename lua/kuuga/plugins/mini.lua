return {
	"echasnovski/mini.nvim",
	event = "BufReadPost",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"FTerm",
				"Trouble",
				"help",
				"lazy",
				"mason",
				"man",
				"dashboard",
			},
			callback = function() vim.b.miniindentscope_disable = true end,
		})
	end,
	config = function()
		local bracked = require("mini.bracketed")
		local pairs = require("mini.pairs")
		local ai = require("mini.ai")
		local surround = require("mini.surround")
		local comment = require("mini.comment")

		bracked.setup()

		pairs.setup({
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

		ai.setup({
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

		surround.setup({
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

		comment.setup({
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
		})
	end,
}
