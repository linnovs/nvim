require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "ansible-language-server", "ansible-lint" })
require("kuuga.lib.linter").setup({ "ansible_lint" })
vim.lsp.enable({ "ansiblels" })
