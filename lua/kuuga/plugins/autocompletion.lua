-- HACK: this fix the missing fields until [this](https://github.com/Saghen/blink.cmp/issues/427) got fixed.
---@diagnostic disable: missing-fields

return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "enter" },
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev", "dadbod" },
			},
			providers = {
				lsp = { name = "LSP", fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			},
		},
		completion = {
			list = { selection = "manual" },
			documentation = {
				window = {
					border = "rounded",
				},
			},
			ghost_text = {
				enabled = true,
			},
		},
	},
}
