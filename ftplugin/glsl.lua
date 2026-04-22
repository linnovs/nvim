require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "glsl_analyzer" })
vim.lsp.enable({ "glsl_analyzer" })
