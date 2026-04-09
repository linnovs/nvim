local gh = require("kuuga.helper.gh")
vim.pack.add({ { src = gh("mason-org/mason.nvim"), version = vim.version.range("*") } })
require("mason").setup({
	ui = {
		border = "rounded",
	},
})
