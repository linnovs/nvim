local gh = require("kuuga.lib.pack-source.gh")
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({
			gh("HiPhish/rainbow-delimiters.nvim"),
		})
	end,
})
