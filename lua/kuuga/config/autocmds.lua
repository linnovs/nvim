local autocmd = vim.api.nvim_create_autocmd
local home = vim.fn.expand("~")

autocmd({ "FocusGained", "TermClose", "TermLeave" }, { command = "checktime" })
autocmd("VimResized", { command = "tabdo wincmd =" })
autocmd("TextYankPost", { callback = function() vim.highlight.on_yank() end })

autocmd("BufWritePost", {
	pattern = home .. "/.local/share/chezmoi/*",
	callback = function(args)
		local file = args.file:match("^.+/(.+)$") or args.file
		local is_run = string.sub(file, 1, string.len("run_")) == "run_"
		local is_chezmoi = string.sub(file, 1, string.len(".chezmoi")) == ".chezmoi"
		if is_run or is_chezmoi then return end
		os.execute("chezmoi apply --refresh-externals=never --source-path " .. args.file)
		vim.notify("Apply source " .. args.file .. " to target")
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
		if vim.fn.filereadable(file) then
			vim.uv.spawn(
				file,
				---@diagnostic disable-next-line: missing-fields
				{},
				function() end
			)
		end
	end,
})

autocmd("BufEnter", { pattern = { "term://*", "*COMMIT_EDITMSG" }, command = "startinsert" })
autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.tf", command = "set filetype=terraform" })
autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.rasi", command = "set filetype=rasi" })
autocmd({ "BufReadPost", "BufNewFile" }, { pattern = "*.wgsl", command = "set filetype=wgsl" })
autocmd("FileType", { pattern = "gitcommit,gitrebase,gitconfig", command = "set bufhidden=delete" })
