local gh = require("kuuga.lib.pack-source.gh")
vim.pack.add({ { src = gh("mason-org/mason.nvim"), version = vim.version.range("*") } })
require("mason").setup({
	ui = {
		border = "rounded",
	},
})
