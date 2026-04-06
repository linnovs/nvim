vim.opt.expandtab = false

require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "stylua", "lua-language-server" })
vim.lsp.enable({ "lua_ls" })
