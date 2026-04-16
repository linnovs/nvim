vim.opt.expandtab = false

local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("folke/lazydev.nvim") })
require("lazydev").setup()

require("kuuga.lib.treesitter").start()
require("kuuga.lib.mason").install({ "stylua", "lua-language-server" })
require("kuuga.lib.formatter").setup({ "stylua" })
vim.lsp.enable({ "lua_ls" })
