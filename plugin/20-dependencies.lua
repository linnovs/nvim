local gh = require("kuuga.helper.gh")
vim.pack.add({
	gh("brenoprata10/nvim-highlight-colors"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("b0o/schemastore.nvim"),
})

require("nvim-highlight-colors").setup({ render = "virtual" })
require("nvim-web-devicons").setup()
