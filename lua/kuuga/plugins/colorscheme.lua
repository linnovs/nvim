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
			transparent_background = false,
			show_end_of_buffer = true,
			custom_highlights = function(colors)
				return {
					DiagnosticUnderlineError = { undercurl = true },
					DiagnosticUnderlineWarn = { undercurl = true },
					DiagnosticUnderlineInfo = { undercurl = true },
					DiagnosticUnderlineHint = { undercurl = true },
					DiagnosticUnderlineOk = { undercurl = true, sp = "LightGreen" },
					DashboardHeader = { fg = colors.mauve },
					DashboardDesc = { fg = colors.lavender },
					DashboardKey = { fg = colors.green },
					DashboardIcon = { fg = colors.lavender },
				}
			end,
			integrations = {
				alpha = true,
				barbecue = {
					dim_dirname = true,
					bold_basename = true,
					dim_context = false,
					alt_background = false,
				},
				blink_cmp = true,
				cmp = true,
				dap = true,
				dap_ui = true,
				dashboard = true,
				flash = true,
				fidget = false,
				gitsigns = true,
				harpoon = true,
				headlines = true,
				illuminate = true,
				indent_blankline = {
					enabled = true,
				},
				lsp_trouble = true,
				markdown = true,
				mason = true,
				mini = {
					enabled = true,
					indentscope_color = "mauve",
				},
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "undercurl" },
						hints = { "undercurl" },
						warnings = { "undercurl" },
						information = { "undercurl" },
					},
					inlay_hints = {
						background = true,
					},
				},
				navic = {
					enabled = true,
					custom_bg = "NONE",
				},
				neogit = true,
				noice = true,
				notify = true,
				octo = true,
				snacks = true,
				telescope = {
					enabled = true,
				},
				treesitter = true,
				treesitter_context = true,
				which_key = true,
			},
		}
	end,
}
