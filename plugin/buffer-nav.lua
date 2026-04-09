local gh = require("kuuga.lib.pack-source.gh")
vim.schedule(function()
	vim.pack.add({ { src = gh("mistweaverco/bafa.nvim"), version = vim.version.range("*") } })
	require("kuuga.lib.keymap")(
		"n",
		"<Leader>s",
		function()
			require("bafa.ui").toggle({
				with_jump_labels = true,
			})
		end,
		"Buffer navigation with bafa.nvim"
	)
	require("bafa").setup({
		ui = {
			jump_labels = {
					-- stylua: ignore start
					keys = {
						"a", "r", "s", "t", "n", "e", "i", "o", -- home row
						"q", "w", "f", "p", "l", "u", "y", ";", -- top row
						"z", "x", "c", "k", "h", ",", ".",      -- bottom row
					},
				-- stylua: ignore end
			},
		},
	})
end)
