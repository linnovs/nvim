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
			flavor = "mocha",
			background = {
				light = "latte",
				dark = "mocha",
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
			auto_integrations = true,
		}
	end,
}
