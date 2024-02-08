return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = function()
		local harpoon = require("harpoon")

		return {
			{
				"<leader>hf",
				function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Show marks",
			},
			{
				"<leader>ha",
				function()
					harpoon:list():append()
				end,
				desc = "Add mark",
			},
			{
				"<leader>hn",
				function()
					harpoon:list():select(1)
				end,
				desc = "Select mark 1",
			},
			{
				"<leader>he",
				function()
					harpoon:list():select(2)
				end,
				desc = "Select mark 2",
			},
			{
				"<leader>hi",
				function()
					harpoon:list():select(3)
				end,
				desc = "Select mark 3",
			},
			{
				"<leader>ho",
				function()
					harpoon:list():select(4)
				end,
				desc = "Select mark 4",
			},
			{
				"<C-S-P>",
				function()
					harpoon:list():prev()
				end,
				desc = "Select prev mark",
			},
			{
				"<C-S-N>",
				function()
					harpoon:list():next()
				end,
				desc = "Select next mark",
			},
		}
	end,
}
