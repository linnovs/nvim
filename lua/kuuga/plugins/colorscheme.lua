return {
	"catppuccin/nvim",
	lazy = false,
	priority = 1000,
	name = "catppuccin",
	opts = function()
		return {
			flavor = "macchiato",
			background = {
				light = "latte",
				dark = "macchiato",
			},
			transparent_background = not vim.g.neovide,
			custom_highlights = function(colors)
				local telescopePreviewBg = colors.base
				if vim.g.neovide then
					telescopePreviewBg = colors.crust
				end

				return {
					TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },
					TelescopePromptPrefix = { bg = colors.surface0 },
					TelescopePromptNormal = { bg = colors.surface0 },
					TelescopeResultsNormal = { bg = colors.mantle },
					TelescopePreviewNormal = { bg = telescopePreviewBg },
					TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
					TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
					TelescopePreviewBorder = { bg = telescopePreviewBg, fg = telescopePreviewBg },
					TelescopePromptTitle = { bg = colors.mauve, fg = colors.mantle },
					TelescopeResultsTitle = { fg = colors.mantle },
					TelescopePreviewTitle = { bg = colors.sapphire, fg = colors.mantle },
					DiagnosticUnderlineError = { undercurl = true },
					DiagnosticUnderlineWarn = { undercurl = true },
					DiagnosticUnderlineInfo = { undercurl = true },
					DiagnosticUnderlineHint = { undercurl = true },
					DiagnosticUnderlineOk = { undercurl = true, sp = "LightGreen" },
					Pmenu = { fg = colors.text, bg = colors.base },
					NormalFloat = { fg = colors.text, bg = colors.base },
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
				cmp = true,
				dap = true,
				dap_ui = true,
				dashboard = true,
				flash = true,
				gitsigns = true,
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
