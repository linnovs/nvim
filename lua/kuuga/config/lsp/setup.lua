local configpath = vim.fn.stdpath("config") .. "/lspconfig"
local handle = vim.uv.fs_scandir(configpath)

while handle do
	local name, _ = vim.uv.fs_scandir_next(handle)
	if not name then break end

	local fname = configpath .. "/" .. name

	if fname:sub(-4) == ".lua" then
		local mod, err = loadfile(fname)
		if mod then vim.lsp.config(name:sub(1, -5), mod()) end

		if err then
			Snacks.notify.error("Error loading lspconfig: " .. err)
			goto continue
		end
	end
	::continue::
end

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
	"typos_lsp",
	"vue_ls",
	"yamlls",
	"zls",
})
