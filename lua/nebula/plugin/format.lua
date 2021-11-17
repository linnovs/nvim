require("format").setup({
	["*"] = {
		cmd = { "sed -i 's/[ \t]*$//'" },
	},
	lua = {
		{
			cmd = { "stylua" },
		},
	},
	rust = {
		{
			cmd = { "rustfmt --emit=stdout" },
		},
	},
	toml = {
		{
			cmd = { "prettier -w" },
		},
	},
	gdscript = {
		{
			cmd = { "gdformat" },
		},
	},
	go = {
		{ cmd = { "gofmt -w", "goimports -w", tempfile_postfix = ".tmp" } },
	},
})

require("nebula.nvim_augroup").creates({
	format = {
		{ "BufWritePost", "*", "FormatWrite" },
	},
})
