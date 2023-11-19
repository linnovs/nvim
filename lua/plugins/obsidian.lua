return {
	{
		"epwalsh/obsidian.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = {
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
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
			workspaces = {
				{
					name = "personal",
					path = "~/Documents/Obsidian Vault",
				},
			},
			notes_subdir = "notes",
			daily_notes = {
				folder = "notes/dailies",
			},
			completion = { nvim_cmp = true },
		},
	},
}
