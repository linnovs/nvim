require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "docker-language-server" })
vim.lsp.enable({ "docker_language_server" })
