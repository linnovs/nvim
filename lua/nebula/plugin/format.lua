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
		gdscript = {
			function()
				return {
					exe = "gdformat",
					args = { vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
					stdin = false,
				}
			end,
		},
		go = {
			function()
				return {
					exe = "gofmt",
					args = { "-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
					stdin = false,
				}
			end,
			function()
				return {
					exe = "goimports",
					args = { "-w", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)) },
					stdin = false,
				}
			end,
		},
	},
})

require("nebula.nvim_augroup").creates({
	format = {
		{ "BufWritePost", "*", [[%s/\s\+$//e]] },
		{ "BufWritePost", "*", [[%s/\s\+\%$//e]] },
		{ "BufWritePost", "*.lua,*.rs,*.toml,*.gd,*.go", "FormatWrite" },
	},
})
