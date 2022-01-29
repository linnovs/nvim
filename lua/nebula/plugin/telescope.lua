local telescope = require("telescope")
local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local z_config = require("telescope._extensions.zoxide.config")
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
				["<C-h>"] = "which_key",
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
		zoxide = {
			theme = "dropdown",
		},
	},
})

telescope.load_extension("zoxide")

z_config.setup({
	mappings = {
		default = {
			after_action = function(selection)
				print("Directory changed to " .. selection.path)
				vim.cmd("NvimTreeToggle")
			end,
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
vimp.nnoremap("<Leader>todo", "<CMD>TodoTelescope<CR>")
vimp.nnoremap("<Leader>z", "<CMD>Telescope zoxide list<CR>")
