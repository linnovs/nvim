local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("neovim/nvim-lspconfig") })
require("kuuga.lib.mason").install({ "harper-ls", "typos-lsp", "copilot-language-server" })
vim.lsp.enable({ "harper_ls", "typos_lsp", "copilot" })
