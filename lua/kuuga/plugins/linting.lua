local linters = require("kuuga.lib.tools").linters

return {
	"mfussenegger/nvim-lint",
	event = "BufReadPost",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = linters

		lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.HINT
			return diagnostic
		end)

		vim.api.nvim_create_autocmd("User", {
			pattern = "QoLToggleSpelling",
			callback = function(evt)
				local ns = lint.get_namespace("cspell")

				if not Snacks.toggle.option("spell"):get() then
					vim.diagnostic.reset(ns, evt.buf)
				else
					lint.try_lint("cspell")
				end
			end,
		})

		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()

				if vim.o.spell then
					lint.try_lint("cspell")
				end
			end,
		})
	end,
}
