require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "qmlls" })
require("kuuga.lib.formatter").setup({ "qmlformat" })
vim.lsp.enable({ "qmlls" })
