local gh = require("kuuga.lib.pack-source.gh")
vim.pack.add({ { src = gh("folke/persistence.nvim"), version = vim.version.range("*") } })
require("persistence").setup()
