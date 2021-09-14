local colors = require("nebula.colors")
local lsp = colors.lsp
local autocmds = {
	set_formatoptions = {
		{ "BufEnter", "*", "setlocal formatoptions-=o" },
	},
	LspColors = {
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultError guifg=" .. lsp.error },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultWarning guifg=" .. lsp.warning },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultInformation guifg=" .. lsp.information },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultHint guifg=" .. lsp.hint },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineError gui=undercurl guisp=" .. lsp.error },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineWarning gui=undercurl guisp=" .. lsp.warning },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineInformation gui=undercurl guisp=" .. lsp.information },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineHint gui=undercurl guisp=" .. lsp.hint },
	},
}

require("nebula.nvim_augroup").creates(autocmds)
