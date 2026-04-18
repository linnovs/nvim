---@type vim.lsp.Config
return {
	---@module "lspconfig"
	---@type lspconfig.settings.lua_ls
	settings = {
		Lua = {
			hint = {
				enable = true,
			},
			format = {
				enable = false,
			},
			workspace = {
				checkThirdParty = false,
				ignoreSubmodules = true,
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
}
