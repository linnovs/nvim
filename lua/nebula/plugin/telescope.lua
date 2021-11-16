local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local vimp = require("vimp")

telescope.setup({
	defaults = {
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		set_env = { ["COLORTERM"] = "truecolor" },
		mappings = {
			i = {
				["<ESC>"] = actions.close,
			},
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			hidden = true,
			follow = true,
		},
		live_grep = {
			theme = "dropdown",
		},
		buffers = {
			theme = "dropdown",
		},
		help_tags = {
			theme = "dropdown",
		},
	},
})

vimp.nnoremap("<Leader><Leader>", function()
	builtin.find_files()
end)
vimp.nnoremap("<Leader>fg", function()
	builtin.live_grep()
end)
vimp.nnoremap("<Leader>fb", function()
	builtin.buffers()
end)
vimp.nnoremap("<Leader>fh", function()
	builtin.help_tags()
end)
