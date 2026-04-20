require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "json-lsp", "oxfmt" })
require("kuuga.lib.formatter").setup({ "oxfmt" })
vim.lsp.enable({ "jsonls" })
