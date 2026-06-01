local gh = require("kuuga.helper.gh")
vim.schedule(function()
	vim.pack.add({
		gh("MahanRahmati/blink-nerdfont.nvim"),
		gh("rafamadriz/friendly-snippets"),
		{ src = gh("saghen/blink.cmp"), version = vim.version.range("^1") },
	})

	require("blink.cmp").setup({
		keymap = {
			preset = "enter",
			["<Tab>"] = {
				"snippet_forward",
				"fallback",
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer", "nerdfont" },
			per_filetype = {
				sql = { "lsp", "snippets", "buffer", "dadbob" },
				psql = { "lsp", "snippets", "buffer", "dadbob" },
				mysql = { "lsp", "snippets", "buffer", "dadbob" },
				oil = { "lsp", "path", "buffer" },
			},
			providers = {
				nerdfont = {
					name = "NerdFont",
					module = "blink-nerdfont",
					score_offset = 15,
					opts = { insert = true },
				},
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
				winblend = 0,
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
					},
				},
			},
		},
	})
end)
