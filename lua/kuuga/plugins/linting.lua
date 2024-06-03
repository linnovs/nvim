local linters = require("kuuga.lib.tools").linters

return {
	"mfussenegger/nvim-lint",
	event = "BufNew",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
