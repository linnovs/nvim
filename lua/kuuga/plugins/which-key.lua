return {
	"folke/which-key.nvim",
	dependencies = {
		"echasnovski/mini.icons",
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer local keymaps (which-key)",
		},
	},
	opts = {
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
	},
}
