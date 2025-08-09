return {
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.ghaction" },
	settings = {
		yaml = {
			schemaStore = {
				enable = false,
				url = "",
			},
		},
	},
	before_init = function(_, config) config.settings.yaml.schemas = require("schemastore").yaml.schemas() end,
}
