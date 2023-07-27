return {
	{
		"mhartington/formatter.nvim",
		cmd = { "Format", "FormatWrite" },
		init = function()
			vim.api.nvim_create_autocmd("BufWritePost", {
				callback = function()
					vim.cmd("FormatWrite")
				end,
			})
		end,
		config = function()
			-- local defaults = require("formatter.defaults")
			local filetypes = require("formatter.filetypes")

			require("formatter").setup({
				logging = false,
				filetype = {
					lua = {
						filetypes.lua.stylua,
					},
				},
			})
		end,
	},
}
