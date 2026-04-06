local keymap = require("kuuga.lib.keymap")

vim.schedule(function()
	vim.pack.add({ { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = vim.version.range("*") } })

	keymap("n", "<Leader>oo", "<Cmd>Obsidian quick_switch<CR>", "Obsidian quick switch")
	keymap("n", "<Leader>os", "<Cmd>Obsidian search<CR>", "Search Obsidian file")
	keymap("n", "<Leader>on", "<Cmd>Obsidian new<CR>", "New Obsidian note")
	keymap("n", "<Leader>oa", "<Cmd>Obsidian open<CR>", "Open Obsidian")
	keymap("n", "<Leader>o2d", "<Cmd>Obsidian today<CR>", "Open Obsidian today note")
	keymap("n", "<Leader>oyd", "<Cmd>Obsidian today -1<CR>", "Open Obsidian yesterday note")

	require("obsidian").setup({
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
	})
end)
