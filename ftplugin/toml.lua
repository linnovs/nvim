require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "tombi", "codebook" })
require("kuuga.lib.formatter").setup({ "tombi" })
vim.lsp.enable({ "tombi", "codebook" })
