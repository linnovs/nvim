return {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.ghaction" },
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
			schemas = require("schemastore").yaml.schemas(),
		},
	},
}
