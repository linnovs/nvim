local colors = require("nebula.colors")
local lsp = colors.lsp
local git = colors.git

local autocmds = {
	set_formatoptions = {
		{ "BufEnter", "*", "setlocal formatoptions-=o" },
	},
	LspColors = {
		{ "ColorScheme", "*", "highlight DiagnosticError guifg=" .. lsp.error },
		{ "ColorScheme", "*", "highlight DiagnosticWarn guifg=" .. lsp.warning },
		{ "ColorScheme", "*", "highlight DiagnosticInfo guifg=" .. lsp.information },
		{ "ColorScheme", "*", "highlight DiagnosticHint guifg=" .. lsp.hint },
		{ "ColorScheme", "*", "highlight DiagnosticUnderlineError gui=undercurl guisp=" .. lsp.error },
		{ "ColorScheme", "*", "highlight DiagnosticUnderlineWarn gui=undercurl guisp=" .. lsp.warning },
		{ "ColorScheme", "*", "highlight DiagnosticUnderlineInfo gui=undercurl guisp=" .. lsp.information },
		{ "ColorScheme", "*", "highlight DiagnosticUnderlineHint gui=undercurl guisp=" .. lsp.hint },
	},
	GitSignColors = {
		{ "ColorScheme", "*", "highlight GitSignsAdd guifg=" .. git.added },
		{ "ColorScheme", "*", "highlight GitSignsChange guifg=" .. git.modified },
		{ "ColorScheme", "*", "highlight GitSignsDelete guifg=" .. git.removed },
	},
	ChezmoiApply = {
		{ "BufWritePost", "~/.local/share/chezmoi/*", '!chezmoi apply --source-path "%"' },
	},
	I3AutoReload = {
		{ "BufWritePost", "~/.local/share/chezmoi/dot_config/i3/config", "!i3-msg reload" },
	},
	AutoPackerSync = {
		{ "BufWritePost", "~/.config/nvim/lua/plugins.lua", "PackerSync" },
	},
}

require("nebula.nvim_augroup").creates(autocmds)
