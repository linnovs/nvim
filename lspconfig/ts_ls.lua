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
