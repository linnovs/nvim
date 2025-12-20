return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"OXY2DEV/markview.nvim", -- For markdown code blocks see: https://github.com/OXY2DEV/markview.nvim/issues/365#issuecomment-3028249737
		},
		branch = "main",
		build = ":TSUpdate",
		lazy = false,
		opts = {},
		config = function(_, opts)
			require("nvim-treesitter").setup(opts)
			require("kuuga.lib.treesitter")
		end,
	},

	{ "windwp/nvim-ts-autotag", event = { "BufReadPost", "BufWritePost", "BufNewFile" }, opts = {} },

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		opts = {
			auto_command = false,
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		init = function() vim.g.no_plugin_maps = true end,
		event = "VeryLazy",
		opts = {
			select = {
				lookahead = true,
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "<c-v>", -- blockwise
				},
				include_surrounding_whitespace = false,
			},
		},
		config = function()
			local select = require("nvim-treesitter-textobjects.select")
			local map = function(lhs, query, query_group, desc)
				vim.keymap.set(
					{ "x", "o" },
					lhs,
					function() select.select_textobject(query, query_group) end,
					{ desc = desc }
				)
			end

			map("af", "@function.outer", "textobjects", "Select around function")
			map("if", "@function.inner", "textobjects", "Select inside function")
			map("ac", "@class.outer", "textobjects", "Select around class")
			map("ic", "@class.inner", "textobjects", "Select inside class")
			map("as", "@local.scope", "locals", "Select language scope")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		lazy = false,
		opts = { mode = "cursor" },
	},
}
