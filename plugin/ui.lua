vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({
			"https://github.com/HiPhish/rainbow-delimiters.nvim",
		})
	end,
})
