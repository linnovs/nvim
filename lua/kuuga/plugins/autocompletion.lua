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
		},
		highlight = {
			use_nvim_cmp_as_default = true,
		},
		nerd_font_variant = "mono",
	},
}
