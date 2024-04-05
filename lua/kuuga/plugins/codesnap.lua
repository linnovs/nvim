return {
	"mistricky/codesnap.nvim",
	build = "make",
	keys = {
		{
			"<LEADER>cs",
			":CodeSnap<CR>",
			mode = "x",
			desc = "Save snapped code to clipboard",
		},
		{
			"<LEADER>cS",
			":CodeSnapSave<CR>",
			mode = "x",
			desc = "Save snapped code to file",
		},
	},
	cmd = {
		"CodeSnap",
		"CodeSnapSave",
	},
	opts = {
		has_breakcrumbs = true,
		watermark = "Linnovs",
		bg_theme = "grape",
	},
}
