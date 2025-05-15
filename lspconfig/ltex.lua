return {
	filetypes = {
		"bib",
		"gitcommit",
		"markdown",
		"org",
		"plaintex",
		"rst",
		"rnoweb",
		"tex",
		"pandoc",
		"quarto",
		"rmd",
		"NeogitCommitMessage",
	},
	settings = {
		ltex = {
			enabled = true,
			language = "en-US",
			checkFrequency = "save",
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "zh-CN",
			},
		},
	},
	flags = { debounce_text_changes = 300 },
}
