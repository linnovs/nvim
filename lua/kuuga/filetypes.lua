vim.filetype.add({
	extension = {
		base = "yaml",
	},
	filename = {
		PKGBUILD = "sh.pkgbuild",
	},
	pattern = {
		["compose%.ya?ml"] = "yaml.docker-compose",
	},
})
