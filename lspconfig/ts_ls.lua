local home = vim.fn.expand("~")

return {
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = home .. "/.local/share/npm/lib/node_modules/@vue/typescript-plugin",
				languages = { "javascript", "typescript", "vue" },
			},
		},
		preferences = {
			includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayVariableTypeHints = false,
			includeInlayFunctionParameterTypeHints = false,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = false,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
			importModuleSpecifierPreference = "non-relative", -- 'relative' | 'non-relative' | 'project-relative'
		},
	},
	filetypes = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
		"vue",
	},
}
