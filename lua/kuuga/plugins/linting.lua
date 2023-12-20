local linters = require("kuuga.lib.tools").linters

return {
	{
		"mfussenegger/nvim-lint",
		event = "BufReadPre",
		config = function()
			local M = {}
			local lint = require("lint")
			lint.linters_by_ft = linters

			function M.debounce(ms, fn)
				local timer = vim.loop.new_timer()
				return function(...)
					local argv = { ... }
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)(unpack(argv))
					end)
				end
			end

			function M.lint()
				local names = lint.linters_by_ft[vim.bo.filetype] or {}

				if #names > 0 then
					lint.try_lint(names)
				end
			end

			vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = M.debounce(100, M.lint),
			})
		end,
	},
}
