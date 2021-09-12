local autocmds = {
	set_formatoptions = {
		{ "BufEnter", "*", "setlocal formatoptions-=o" },
	},
}

require("nebula.nvim_augroup").creates(autocmds)
