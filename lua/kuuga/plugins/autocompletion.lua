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
			"MahanRahmati/blink-nerdfont.nvim",
			"fang2hou/blink-copilot",
		},
		version = false,
		build = "cargo build --release",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				preset = "enter",
				["<tab>"] = {
					"snippet_forward",
					function() require("sidekick").nes_jump_or_apply() end,
					"fallback",
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "nerdfont", "copilot" },
				per_filetype = {
					lua = { "lsp", "path", "snippets", "buffer", "lazydev", "nerdfont", "copilot" },
					sql = { "lsp", "snippets", "buffer", "dadbod", "copilot" },
					psql = { "lsp", "snippets", "buffer", "dadbod", "copilot" },
					mysql = { "lsp", "snippets", "buffer", "dadbod", "copilot" },
					oil = { "lsp", "path", "snippets", "buffer", "copilot" },
					codecompanion = { "codecompanion" },
				},
				providers = {
					copilot = {
						name = "Copilot",
						module = "blink-copilot",
						score_offset = 100,
						async = true,
					},
					nerdfont = {
						name = "Nerd Fonts",
						module = "blink-nerdfont",
						score_offset = 15,
						opts = { insert = true },
					},
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
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
			},
		},
	},
}
