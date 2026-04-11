require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "bash-language-server", "beautysh" })
require("kuuga.lib.formatter").setup({ "beautysh" })
vim.lsp.enable({ "bashls" })
