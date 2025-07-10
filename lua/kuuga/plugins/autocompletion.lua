return {
	{
		"xzbdmw/colorful-menu.nvim",
		lazy = true,
	},

	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"echasnovski/mini.nvim",
			"xzbdmw/colorful-menu.nvim",
			"Exafunction/codeium.nvim",
		},
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				per_filetype = {
					lua = { "lsp", "path", "snippets", "buffer", "lazydev" },
					sql = { "lsp", "snippets", "buffer", "dadbod" },
					psql = { "lsp", "snippets", "buffer", "dadbod" },
					mysql = { "lsp", "snippets", "buffer", "dadbod" },
					oil = { "lsp", "path", "snippets", "buffer" },
					DressingInput = { "lsp", "path", "buffer" },
				},
				providers = {
					lsp = { name = "LSP" },
					-- codeium = { name = "Codeium", module = "codeium.blink", async = true },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
			signature = { enabled = true },
			completion = {
				list = { selection = { preselect = false, auto_insert = false } },
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 200,
					window = {
						border = "rounded",
						winblend = 30,
					},
				},
				menu = {
					winblend = 30,
					draw = {
						columns = { { "kind_icon" }, { "label", gap = 1 }, { "source_name" } },
						components = {
							kind_icon = {
								text = function(ctx)
									-- default kind icon
									local icon = ctx.kind_icon
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr ~= "" then icon = color_item.abbr end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									-- default highlight group
									local highlight = "BlinkCmpKind" .. ctx.kind
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
							label = {
								text = function(ctx) return require("colorful-menu").blink_components_text(ctx) end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
				ghost_text = { enabled = true },
			},
		},
	},
}
