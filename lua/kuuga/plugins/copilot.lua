return {
	"zbirenbaum/copilot.lua",
	dependencies = { "AndreM222/copilot-lualine" },
	event = "InsertEnter",
	cmd = "Copilot",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
		filetypes = {
			markdown = true,
			help = true,
		},
	},
}
