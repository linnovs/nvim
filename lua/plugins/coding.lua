return {
	{
		"echasnovski/mini.comment",
		opts = {
			options = {
				custom_commentstring = function()
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
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
		"echasnovski/mini.pairs",
		events = "BufReadPost",
		opts = {},
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
		"jcdickinson/codeium.nvim",
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
		opts = {},
	},

	-- parinfer
	{
		"gpanders/nvim-parinfer",
		ft = { "clojure", "scheme", "lisp", "racket", "hy", "fennel", "janet", "carp", "wast", "yuck", "dune" },
	},
}
