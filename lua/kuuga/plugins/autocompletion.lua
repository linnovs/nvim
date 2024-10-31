return {
	"saghen/blink.cmp",
	lazy = false,
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "v0.*",
	---@module 'blink.cmp.config'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide" },
			["<CR>"] = { "select_and_accept", "fallback" },

			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
		accept = {
			auto_brackets = { enabled = true },
		},
		windows = {
			autocomplete = {
				border = "rounded",
				selection = "manual",
				draw = function(ctx)
					return {
						" ",
						{ ctx.kind_icon, ctx.icon_gap, hl_group = "BlinkCmpKind" .. ctx.kind },
						" ",
						{
							ctx.label,
							ctx.kind == "Snippet" and "~" or nil,
							fill = true,
							hl_group = ctx.deprecated and "BlinkCmpLabelDeprecated" or "BlinkCmpLabel",
							max_width = 50,
						},
						" ",
						{ ctx.kind, hl_group = "BlinkCmpKind" .. ctx.kind },
						" ",
					}
				end,
			},
			documentation = {
				border = "rounded",
			},
			ghost_text = {
				enabled = true,
			},
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "mono",
	},
}
