vim.pack.add({ { src = "https://github.com/mason-org/mason.nvim", version = vim.version.range("*") } })
require("mason").setup({
	ui = {
		border = "rounded",
	},
})
