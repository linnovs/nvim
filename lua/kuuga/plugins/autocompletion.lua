-- HACK: this fix the missing fields until [this](https://github.com/Saghen/blink.cmp/issues/427) got fixed.
---@diagnostic disable: missing-fields

return {
	{
		"saghen/blink.compat",
		version = "*",
		lazy = true,
		opts = {},
		dependencies = {
			{ "Exafunction/codeium.nvim", opts = true },
		},
	},

	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"echasnovski/mini.nvim",
		},
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			sources = {
				completion = {
					enabled_providers = { "lsp", "codeium", "path", "snippets", "buffer", "lazydev", "dadbod" },
				},
				providers = {
					lsp = { name = "LSP", fallback_for = { "lazydev" } },
					codeium = { name = "codeium", module = "blink.compat.source" },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
			completion = {
				list = { selection = "manual" },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
					},
				},
				menu = {
					draw = {
						columns = {
							{ "kind_icon" },
							{ "label", "label_description", gap = 1 },
							{ "kind" },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				ghost_text = {
					enabled = true,
				},
			},
		},
	},
}
