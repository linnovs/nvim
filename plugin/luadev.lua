require("kuuga.lib.ft-autocmd").autocmd(function()
	vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
	require("lazydev").setup({
		library = {
			{ path = "snacks.nvim", words = { "Snacks" } },
			{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		},
	})
end, { pattern = "lua" })
