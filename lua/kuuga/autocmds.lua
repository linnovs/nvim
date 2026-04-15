local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local homedir = os.getenv("HOME")

autocmd(
	{ "FocusGained", "TermClose", "TermLeave" },
	{ command = "checktime", desc = "Check for file changes when focus is gained or terminal is closed/left" }
)
autocmd("VimResized", { command = "tabdo wincmd =", desc = "Resize windows when Vim is resized" })
autocmd("TextYankPost", { callback = function() vim.hl.on_yank() end, desc = "Highlight yanked text" })
autocmd("BufWritePost", {
	pattern = homedir .. "/.local/share/chezmoi/*",
	callback = require("kuuga.lib.chezmoi"),
	desc = "Run chezmoi apply on buffer write",
})
autocmd(
	"FileType",
	{ pattern = "gitcommit", command = "startinsert", desc = "Auto-enter insert mode for git commit messages" }
)
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
