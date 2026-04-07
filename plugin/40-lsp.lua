vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
require("kuuga.lib.mason").install({ "harper-ls", "typos-lsp" })
vim.lsp.enable({ "harper_ls", "typos_lsp" })
