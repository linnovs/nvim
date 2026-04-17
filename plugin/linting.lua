local gh = require("kuuga.helper.gh")

vim.pack.add({ gh("mfussenegger/nvim-lint") })

require("lint").linters_by_ft = { ["*"] = {} } -- reset
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*",
	callback = function() require("lint").try_lint() end,
})
