local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

return {
	"mfussenegger/nvim-lint",
	event = "BufReadPost",
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			["*"] = {}, -- this need to add a `try_lint(linter)` at the end of the autocmd
			rust = { "clippy" },
			python = { "ruff" },
			proto = { "protolint" },
			ghaction = { "actionlint" },
			go = { "golangcilint" },
			typescript = { "oxlint" },
		}

		lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.HINT
			return diagnostic
		end)

		autocmd("User", {
			pattern = "QoLToggleSpelling",
			callback = function(evt)
				local ns = lint.get_namespace("cspell")

				if not vim.o.spell then
					vim.diagnostic.reset(ns, evt.buf)
				else
					lint.try_lint("cspell")
				end
			end,
		})

		autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = augroup("nvim-lint", { clear = true }),
			callback = function()
				lint.try_lint()

				if vim.o.spell then lint.try_lint("cspell") end
			end,
		})
	end,
}
