vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.pack.add({ "https://github.com/mfussenegger/nvim-lint" })

		local lint = require("lint")
		lint.linters_by_ft = {
			["*"] = {}, -- this need to add a `try_lint(linter)` at the end of the autocmd
			rust = { "clippy" },
			ghaction = { "actionlint" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("KuugaLint", { clear = true }),
			callback = function() lint.try_lint() end,
		})
	end,
})
