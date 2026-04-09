local gh = require("kuuga.helper.gh")
vim.schedule(function()
	vim.pack.add({ { src = gh("folke/which-key.nvim"), version = vim.version.range("*") } })
	require("kuuga.lib.keymap")(
		"n",
		"<Leader>?",
		function() require("which-key").show({ global = false }) end,
		"Buffer local keymaps (which-key)"
	)

	require("which-key").setup({
		preset = "helix",
		spec = {
			{ "g", group = "goto" },
			{ "]", group = "next" },
			{ "[", group = "prev" },
			{ "<leader>c", group = "code" },
			{ "<leader>d", group = "debug" },
			{ "<leader>f", group = "find" },
			{ "<leader>g", group = "git" },
			{ "<leader>gh", group = "hunks" },
			{ "<leader>h", group = "harpoon" },
			{ "<leader>w", group = "windows" },
			{ "<leader>x", group = "diagnostics/quickfix" },
			{ "<leader>o", group = "obisdian/explorer" },
			{ "<leader>l", group = "lazy" },
			{ "<leader>ze", group = "zen" },
		},
	})
end)
