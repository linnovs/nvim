vim.filetype.add({
	extension = {
		base = "yaml",
	},
	pattern = {
		["compose%.ya?ml"] = "yaml.docker-compose",
	},
})
