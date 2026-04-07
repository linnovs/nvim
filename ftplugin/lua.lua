vim.opt.expandtab = false

require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "stylua", "lua-language-server" })
require("kuuga.lib.formatter").setup({ "stylua" })
vim.lsp.enable({ "lua_ls" })
