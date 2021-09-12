require("format").setup({
	["*"] = { { cmd = { [[sed -i 's/[ \t]*$//']] } } },
	lua = { { cmd = { [[stylua]] } } },
})

require("nebula.nvim_augroup").creates({
	format = {
		{ "BufWritePost", "*", "FormatWrite" },
	},
})
