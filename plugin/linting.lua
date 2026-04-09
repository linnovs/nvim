local gh = require("kuuga.helper.gh")
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({ gh("mfussenegger/nvim-lint") })
		require("lint").linters_by_ft = { ["*"] = {} } -- reset
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("KuugaLint", { clear = true }),
			callback = function() require("lint").try_lint() end,
		})
	end,
})
