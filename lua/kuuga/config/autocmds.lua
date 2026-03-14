local autocmd = vim.api.nvim_create_autocmd
local home = vim.fn.expand("~")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", { callback = function() vim.hl.on_yank() end })

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/*",
	callback = function(args)
		local after_apply = require("kuuga.lib.chezmoi")
		after_apply.callback(args)
	end,
})

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/dot_config/i3/config",
	callback = function()
		os.execute("i3-msg reload")
		vim.notify("Reload i3")
	end,
})

autocmd({ "VimEnter", "VimLeave" }, {
	callback = function()
		if not vim.env.TMUX_PLUGIN_MANAGER_PATH then return end

		local file = vim.env.TMUX_PLUGIN_MANAGER_PATH .. "/tmux-window-name/scripts/rename_session_windows.py"
		if vim.fn.filereadable(file) then vim.uv.spawn(file, {}, function() end) end
	end,
})

autocmd("User", {
	pattern = "LazyUpdate",
	callback = function()
		local lazy_update = require("kuuga.lib.lazy_update")

		vim.defer_fn(lazy_update.callback, 300)
	end,
})

autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.tf", command = "set filetype=terraform" })
autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.rasi", command = "set filetype=rasi" })
autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.wgsl", command = "set filetype=wgsl" })
autocmd("Filetype", { pattern = "gitcommit", command = "startinsert" })
