return {
	"obsidian-nvim/obsidian.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	version = false,
	event = {
		"BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
		"BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian Vault/**.md",
	},
	keys = {
		{
			"<leader>oo",
			"<CMD>Obsidian quick_switch<CR>",
			desc = "Obsidian Quick Switch",
		},
		{
			"<leader>os",
			"<CMD>Obsidian search<CR>",
			desc = "Obsidian Search",
		},
		{
			"<leader>on",
			"<CMD>Obsidian new<CR>",
			desc = "Obsidian New Note",
		},
		{
			"<leader>oa",
			"<CMD>Obsidian open<CR>",
			desc = "Open Obsidian App",
		},
		{
			"<leader>o2d",
			"<CMD>Obsidian today<CR>",
			desc = "Create Obsidian Today Note",
		},
		{
			"<leader>oyd",
			"<CMD>Obsidian today -1<CR>",
			desc = "Create/Open Obsidian Yesterday Note",
		},
	},
	opts = {
		legacy_commands = false,
		workspaces = {
			{
				name = "personal",
				path = "~/Documents/Obsidian Vault",
			},
		},
		notes_subdir = "Inbox",
		daily_notes = {
			folder = "Journal/dailies",
			date_format = "%Y/%m-%B/%Y-%m-%d",
			template = "daily.md",
		},
		completion = {
			nvim_cmp = false,
			blink = true,
			min_chars = 2,
		},
		new_notes_location = "notes_subdir",
		note_id_func = function(title)
			if title == nil or title == "" then
				return os.date("%Y%m%d%H%M")
			else
				return title
			end
		end,
		templates = {
			folder = "assets/templates",
			date_format = "%Y-%m-%d",
			time_format = "%H:%M",
		},
		open = {
			use_advanced_uri = true,
		},
		picker = {
			name = "snacks.pick",
			mapping = {
				new = "<C-x>",
				insert_link = "<C-l>",
			},
		},
		checkbox = {
			order = { " ", "-", "/", "!", ">", "<", "x" },
		},
	},
}
