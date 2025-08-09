vim.filetype.add({
	pattern = {
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
		[".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
		[".*/.gitea/workflows/.*%.yaml"] = "yaml.ghaction",
		[".*/compose.ya?ml"] = "yaml.docker-compose",
	},
	extension = {
		hujson = "jsonc",
		["http"] = "http",
		psql = "sql",
	},
})
