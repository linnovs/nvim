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
	before_init = function(_, config)
		config.settings.yaml.schemas = require("schemastore").yaml.schemas({
			{
				description = "Docker Compose file schema",
				fileMatch = "compose.yaml",
				name = "docker-compose",
				url = "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json",
			},
		})
	end,
}
