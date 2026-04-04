vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.pack.add({ "https://github.com/folke/lazydev.nvim" })
		require("lazydev").setup({
			library = {
				{ path = "snacks.nvim", words = { "Snacks" } },
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		})
	end,
})
