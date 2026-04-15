local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local homedir = os.getenv("HOME")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", { callback = function() vim.hl.on_yank() end })
autocmd("BufWritePost", { pattern = homedir .. "/.local/share/chezmoi/*", callback = require("kuuga.lib.chezmoi") })
autocmd("FileType", { pattern = "gitcommit", command = "startinsert" })
autocmd({
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
	group = augroup("KuugaStatusLine", { clear = true }),
	desc = "Refresh statusline on various events",
	pattern = "*",
	callback = vim.schedule_wrap(function()
		WinBar.setup()
		StatusLine.setup()
	end),
})
