local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local homedir = os.getenv("HOME")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", { callback = function() vim.hl.on_yank() end })
autocmd("BufWritePost", { pattern = homedir .. "/.local/share/chezmoi/*", callback = require("kuuga.lib.chezmoi") })
autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		if not vim.env.TMUX_PLUGIN_MANAGER_PATH then return end

		local file = vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py"
		if vim.fn.filereadable(file) then vim.uv.spawn(file, {}, function() end) end
	end,
})
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
autocmd("WinClosed", {
	pattern = "*",
	group = augroup("KuugaStatusLineClearup", { clear = true }),
	callback = vim.schedule_wrap(function()
		local winid = vim.api.nvim_get_current_win()
		WinBar.clear_cache(winid)
		StatusLine.clear_cache(winid)
	end),
})
