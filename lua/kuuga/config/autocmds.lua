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

		vim.notify("Apply source " .. args.file .. " to target", vim.log.levels.INFO, {
			title = "chezmoi",
			timeout = 2000,
		})

		local stdout = uv.new_pipe()
		local stdin = uv.new_pipe()
		local notify_opts = { title = "chezmoi", timeout = 2000 }

		if stdin == nil then
			vim.notify("Failed to create stdin pipe", vim.log.levels.ERROR, notify_opts)
			return
		end

		uv.spawn("chezmoi", {
			args = { "apply", "--no-pager", "--no-tty", "--refresh-externals=never", "--source-path", args.file },
			stdio = { stdin, stdout, nil },
			cwd = home .. "/.local/share/chezmoi",
		}, function(code)
			if code ~= 0 then
				if stdout == nil then
					vim.notify("Apply failed with code " .. code, vim.log.levels.ERROR, notify_opts)
					return
				end
				uv.read_start(stdout, function(err, data)
					if err then
						vim.notify("Error reading stderr: " .. err, vim.log.levels.ERROR, notify_opts)
					elseif data then
						vim.notify("Apply failed: " .. data, vim.log.levels.ERROR, notify_opts)
					end
				end)
			else
				vim.notify("Apply succeeded", vim.log.levels.INFO, notify_opts)
			end
		end)

		uv.write(stdin, "diff\n")
		uv.shutdown(stdin)
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
