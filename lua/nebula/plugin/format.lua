require("formatter").setup({
	filetype = {
		lua = {
			function()
				return {
					exe = "stylua",
					args = { "-" },
					stdin = true,
				}
			end,
		},
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},
		toml = {
			function()
				return {
					exe = "prettier -w",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
					stdin = true,
				}
			end,
		},
	},
})

require("nebula.nvim_augroup").creates({
	format = {
		{ "BufWritePost", "*", [[%s/\s\+$//e]] },
		{ "BufWritePost", "*", [[%s/\s\+\%$//e]] },
		{ "BufWritePost", "*.lua,*.rs,*.toml", "FormatWrite" },
	},
})
