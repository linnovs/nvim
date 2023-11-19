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
		events = "BufReadPost",
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
		events = "BufReadPost",
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

			n_lines = 50,
			search_method = "cover_or_next",

			silent = false,
		},
	},

	{
		"echasnovski/mini.pairs",
		events = "BufReadPost",
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

	-- copilot
	{
		"zbirenbaum/copilot.lua",
		dependencies = { "nvim-lualine/lualine.nvim" },
		opts = {
			suggestion = { enabled = false },
			panel = { enabled = false },
		},
		config = function(_, opts)
			vim.defer_fn(function()
				vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
				require("copilot").setup(opts)
			end, 100)
		end,
	},

	-- codeium
	{
		"Exafunction/codeium.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		lazy = true,
		opts = {},
	},

	-- snippet
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
			config = function()
				require("luasnip.loaders.from_vscode").lazy_load()
			end,
		},
		lazy = true,
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},
	},

	-- parinfer
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure", "scheme", "lisp", "racket", "hy", "fennel", "janet", "carp", "wast", "yuck", "dune" },
	},
}
