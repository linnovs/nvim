return {
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufAdd" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		event = "BufReadPost",
		version = false,
		config = true,
	},

	{
		"windwp/nvim-autopairs",
		event = "BufReadPost",
		config = true,
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
