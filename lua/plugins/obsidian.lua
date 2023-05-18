return {
	{
		"epwalsh/obsidian.nvim",
		cmd = {
			"ObsidianCheck",
			"ObsidianToday",
			"ObsidianYesterday",
			"ObsidianOpen",
			"ObsidianNew",
			"ObsidianQuickSwitch",
			"ObsidianBacklinks",
			"ObsidianSearch",
			"ObsidianLink",
			"ObsidianLinkNew",
			"ObsidianFollowLink",
		},
		keys = {
			{
				"<leader>oo",
				"<CMD>ObsidianQuickSwitch<CR>",
				desc = "Obsidian Quick Switch",
			},
			{
				"<leader>os",
				"<CMD>ObsidianSearch<CR>",
				desc = "Obsidian Search",
			},
			{
				"<leader>on",
				"<CMD>ObsidianNew<CR>",
				desc = "Obsidian New Note",
			},
			{
				"<leader>oa",
				"<CMD>ObsidianOpen<CR>",
				desc = "Open Obsidian App",
			},
			{
				"<leader>ot",
				"<CMD>ObsidianToday<CR>",
				desc = "Create Obsidian Today Note",
			},
			{
				"<leader>oy",
				"<CMD>ObsidianToday<CR>",
				desc = "Create/Open Obsidian Yesterday Note",
			},
		},
		opts = {
			dir = "~/Documents/Obsidian Vault",
			notes_subdir = "notes",
			daily_notes = {
				folder = "notes/dailies",
			},
			completion = { nvim_cmp = true },
		},
	},
}
