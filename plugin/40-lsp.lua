if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.log.set_level(vim.log.levels.DEBUG)
else
	vim.lsp.log.set_level(vim.log.levels.ERROR)
end

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })

vim.lsp.enable({
	"bashls",
	"biome",
	"buf_ls",
	"clangd",
	"cmake",
	"copilot",
	"docker_language_server",
	"emmet_language_server",
	"fish_lsp",
	"gdscript",
	"golangci_lint_ls",
	"gopls",
	"harper_ls",
	"hyprls",
	"jsonls",
	"lemminx",
	"lua_ls",
	"nil_ls",
	"omnisharp",
	"oxlint",
	"pyright",
	"qmlls",
	"ruff",
	"rust_analyzer",
	"tailwindcss",
	"terraformls",
	"ts_ls",
	"ty",
	"typos_lsp",
	"vue_ls",
	"yamlls",
	"zls",
})
