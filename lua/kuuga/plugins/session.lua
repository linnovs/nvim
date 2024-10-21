return {
	"folke/persistence.nvim",
	event = "BufReadPre",
	init = function()
		vim.api.nvim_create_autocmd({ "VimEnter" }, {
			callback = function()
				if vim.fn.argc() == 0 then
					vim.defer_fn(function()
						require("persistence").load()
					end, 0)
				end
			end,
		})
	end,
	---@module "persistence.config"
	---@type Persistence.Config
	opts = {},
}
