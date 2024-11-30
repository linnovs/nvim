vim.filetype.add({
	pattern = {
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
		[".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
		[".*/.gitea/workflows/.*%.yaml"] = "yaml.ghaction",
	},
	extension = {
		hujson = "jsonc",
		["http"] = "http",
	},
})
