return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	name = "catppuccin",
	version = false,
	opts = function()
		---@module 'catppuccin.types'
		---@type CatppuccinOptions
		return {
			flavor = "macchiato",
			background = {
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = true,
			show_end_of_buffer = true,
			custom_highlights = function(colors)
				return {
					DiagnosticUnderlineError = { undercurl = true },
					DiagnosticUnderlineWarn = { undercurl = true },
					DiagnosticUnderlineInfo = { undercurl = true },
					DiagnosticUnderlineHint = { undercurl = true },
					DiagnosticUnderlineOk = { undercurl = true, sp = "LightGreen" },
					LspFloatWinNormal = { fg = colors.text, bg = colors.base },
					DashboardHeader = { fg = colors.mauve },
				}
			end,
			default_integrations = false,
			integrations = {
				blink_cmp = {
					enabled = true,
					style = "bordered",
				},
				dap = true,
				dap_ui = true,
				dropbar = {
					enabled = true,
					color_mode = false,
				},
				flash = true,
				gitsigns = true,
				lsp_trouble = true,
				markdown = true,
				markview = true,
				mini = {
					enabled = true,
					indentscope_color = "mauve",
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "bold" },
						hints = { "bold" },
						warnings = { "bold" },
						information = { "bold" },
						ok = { "bold" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
						ok = { "undercurl" },
					},
					inlay_hints = {
						background = true,
					},
				},
				noice = true,
				octo = true,
				snacks = {
					enabled = true,
					indent_scope_color = "mauve",
				},
				treesitter = true,
				treesitter_context = true,
				rainbow_delimiters = true,
			},
		}
	end,
}
