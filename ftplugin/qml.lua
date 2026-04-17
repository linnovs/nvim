require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "qmlls" })
vim.lsp.enable({ "qmlls" })
