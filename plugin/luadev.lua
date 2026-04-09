local gh = require("kuuga.lib.pack-source.gh")
require("kuuga.lib.ft-autocmd").autocmd(function()
	vim.pack.add({ { src = gh("folke/lazydev.nvim"), version = vim.version.range("*") } })
	require("lazydev").setup({
		library = {
			{ path = "snacks.nvim", words = { "Snacks" } },
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end, { pattern = "lua" })
