vim.bo.makeprg = "namcap %"
vim.bo.errorformat = "%t: %m"

require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "bash-language-server", "beautysh", "termux-language-server" })
require("kuuga.lib.linter").setup({ "compiler" })
require("kuuga.lib.formatter").setup({ "beautysh" })
vim.lsp.enable({ "termux_language_server" })
