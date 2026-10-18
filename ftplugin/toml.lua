require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "tombi" })
require("kuuga.lib.formatter").setup({ "tombi" })
vim.lsp.enable({ "tombi" })
