local augroup = vim.api.nvim_create_augroup("KuugaStatusline", { clear = true })

require("kuuga.statusline.highlights")
require("kuuga.statusline.statusline")

local function callback() vim.opt_local.statusline = "%!v:lua.Statusline.render()" end

vim.api.nvim_create_autocmd({
	"WinEnter",
	"BufEnter",
	"BufWritePost",
	"SessionLoadPost",
	"FileChangedShellPost",
	"VimResized",
	"FileType",
	"CursorMoved",
	"CursorMovedI",
	"ModeChanged",
}, {
	group = augroup,
	desc = "Refresh statusline on various events",
	pattern = "*",
	callback = callback,
})

vim.schedule(callback)
