local function get_color_icon(ctx)
	local icon = ctx.kind_icon
	local hl = "BlinkCmpKind" .. ctx.kind

	if ctx.item.source_name == "LSP" then
		local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, { kind = ctx.kind })
		if color_item and color_item.abbr ~= "" then
			icon = color_item.abbr
			hl = color_item.abbr_hl_group
		end
	end

	return icon, hl
end

return {
	{
		"xzbdmw/colorful-menu.nvim",
		lazy = true,
	},

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
			"xzbdmw/colorful-menu.nvim",
		},
		version = "v0.*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = { preset = "enter" },
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "codeium" },
				per_filetype = {
					lua = { "lsp", "path", "snippets", "buffer", "lazydev", "codeium" },
					sql = { "lsp", "snippets", "buffer", "dadbod", "codeium" },
					psql = { "lsp", "snippets", "buffer", "dadbod", "codeium" },
					mysql = { "lsp", "snippets", "buffer", "dadbod", "codeium" },
				},
				providers = {
					lsp = { name = "LSP" },
					codeium = { name = "codeium", module = "blink.compat.source" },
					lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
					dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				},
			},
			signature = { enabled = true },
			completion = {
				list = { selection = "manual" },
				documentation = {
					auto_show = false,
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
							{ "source_name" },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									kind_icon, _ = get_color_icon(ctx)

									return kind_icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									_, hl = get_color_icon(ctx)

									return hl
								end,
							},
							label = {
								width = { fill = true, max = 60 },
								text = function(ctx)
									local hl_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
									if hl_info ~= nil then
										return hl_info.text
									else
										return ctx.label
									end
								end,
								highlight = function(ctx)
									local hl_info = require("colorful-menu").highlights(ctx.item, vim.bo.filetype)
									local hls = {}
									if hl_info ~= nil then
										for _, info in ipairs(hl_info.highlights) do
											table.insert(hls, {
												info.range[1],
												info.range[2],
												group = ctx.deprecated and "BlinkCmpLabelDeprecated" or info[1],
											})
										end
									end
									for _, idx in ipairs(ctx.label_matched_indices) do
										table.insert(hls, { idx, idx + 1, group = "BlinkCmpLabelMatch" })
									end
									return hls
								end,
							},
						},
					},
				},
				ghost_text = { enabled = false },
			},
		},
	},
}
