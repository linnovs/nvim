return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	opts = {
		keymap = {
			accept = "<CR>",
			select_prev = { "<Up>", "<C-p>" },
			select_next = { "<Down>", "<C-n>" },
		},
		accept = {
			auto_brackets = { enabled = true },
		},
		windows = {
			autocomplete = {
				border = "rounded",
				draw = "reversed",
			},
			documentation = {
				border = "rounded",
			},
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "mono",
	},
}
