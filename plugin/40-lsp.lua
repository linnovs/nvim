local gh = require("kuuga.helper.gh")
vim.pack.add({ gh("neovim/nvim-lspconfig") })
require("kuuga.lib.mason").install({ "harper-ls", "copilot-language-server" })
require("kuuga.lib.ft-autocmd").autocmd(function()
	if vim.b.disable_lsp then return end
	vim.lsp.enable({ "harper_ls", "copilot" })
end)
