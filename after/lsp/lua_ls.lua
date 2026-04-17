---@type vim.lsp.Config
return {
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
