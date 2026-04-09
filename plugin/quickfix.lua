local gh = require("kuuga.helper.gh")
local keymap = require("kuuga.lib.keymap")
require("kuuga.lib.ft-autocmd").autocmd(function()
	vim.pack.add({
		gh("kevinhwang91/nvim-bqf"),
		{ src = gh("stevearc/quicker.nvim"), version = vim.version.range("*") },
	})
	keymap("n", "<Leader>q", function() require("quicker").toggle() end, "Toggle quickfix")
	keymap("n", "<Leader>l", function() require("quicker").toggle({ loclist = true }) end, "Toggle location list")
	require("bqf").setup({})
	require("quicker").setup({
		keys = {
			{
				">",
				function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
				desc = "Expand quickfix context",
			},
			{ "<", function() require("quicker").collapse() end, desc = "Collapse quickfix context" },
		},
	})
end, { pattern = "qf" })
