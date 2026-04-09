local gh = require("kuuga.lib.pack-source.gh")
vim.pack.add({
	gh("nvim-lua/plenary.nvim"),
	gh("brenoprata10/nvim-highlight-colors"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("b0o/schemastore.nvim"),
})

require("nvim-highlight-colors").setup({})
