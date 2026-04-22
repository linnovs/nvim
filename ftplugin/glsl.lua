require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "glslls" })
vim.lsp.enable({ "glslls" })
