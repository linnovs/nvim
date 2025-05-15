return {
	settings = {
		pyright = {
			disableOrganizeImports = true, -- use ruff
		},
		python = {
			analysis = {
				ignore = { "*" }, -- use ruff
			},
		},
	},
}
