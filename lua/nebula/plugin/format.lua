require("format").setup({
	["*"] = { { cmd = { [[sed -i 's/[ \t]*$//']] } } },
	lua = { { cmd = { [[stylua]] } } },
	rust = { { cmd = { [[rustfmt]] } } },
	toml = { { cmd = { [[prettier -w]] } } },
})

require("nebula.nvim_augroup").creates({
	format = {
		{ "BufWritePost", "*", "FormatWrite" },
	},
})
