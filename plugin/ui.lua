local gh = require("kuuga.helper.gh")
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({
			gh("HiPhish/rainbow-delimiters.nvim"),
		})
	end,
})
