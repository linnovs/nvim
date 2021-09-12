local autocmds = {
	set_formatoptions = {
		{ "BufEnter", "*", "setlocal formatoptions-=o" },
	},
	LspColors = {
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultError guifg=#db4b4b" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultWarning guifg=#e0af68" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultInformation guifg=#0db9d7" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsDefaultHint guifg=#10b981" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineError gui=undercurl guisp=#db4b4b" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineWarning gui=undercurl guisp=#e0af68" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineInformation gui=undercurl guisp=#0db9d7" },
		{ "ColorScheme", "*", "highlight LspDiagnosticsUnderlineHint gui=undercurl guisp=#10b981" },
	},
}

require("nebula.nvim_augroup").creates(autocmds)
