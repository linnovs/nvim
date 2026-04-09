local gh = require("kuuga.helper.gh")
vim.pack.add({ { src = gh("folke/persistence.nvim"), version = vim.version.range("*") } })
require("persistence").setup()
