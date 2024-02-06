return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		key_labels = { ["<leader>"] = "SPC" },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.register({
			mode = { "n", "v" },
			["g"] = { name = "goto" },
			["]"] = { name = "next" },
			["["] = { name = "prev" },
			["<leader>c"] = { name = "code" },
			["<leader>d"] = { name = "debug" },
			["<leader>f"] = { name = "find" },
			["<leader>g"] = { name = "git" },
			["<leader>gh"] = { name = "hunks" },
			["<leader>h"] = { name = "harpoon" },
			["<leader>w"] = { name = "windows" },
			["<leader>x"] = { name = "diagnostics/quickfix" },
			["<leader>o"] = { name = "obisdian/explorer" },
			["<leader>l"] = { name = "lazy" },
			["<leader>t"] = { name = "terminal" },
			["<leader>ze"] = { name = "zen" },
		})
	end,
}
