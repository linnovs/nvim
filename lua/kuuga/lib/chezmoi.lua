local homedir = os.getenv("HOME")

local function notify(msg, level)
	vim.schedule(function() vim.notify(msg, level, { title = "Chezmoi", timeout = 2000 }) end)
end

--- @param args vim.api.keyset.create_autocmd.callback_args
return function(args)
	local file = args.file:match("^.+/(.+)$") or args.file
	local is_run = string.starts(file, "run_")
	local is_chezmoi = string.starts(file, ".chezmoi")
	local is_commitmsg = string.starts(file, "COMMIT_EDITMSG")

	if is_run or is_chezmoi or is_commitmsg then return end

	local out = vim.system(
		{ "chezmoi", "apply", "--no-pager", "--no-tty", "--refresh-externals=never", "--source-path", args.file },
		{ cwd = homedir .. "/.local/share/chezmoi", stdin = "diff\n" }
	):wait()

	if out.code == 0 then
		notify("Chezmoi apply successful", vim.log.levels.INFO)
	else
		if out.stdout and out.stdout ~= "" then
			notify("Chezmoi apply failed: " .. out.stdout, vim.log.levels.ERROR)
			return
		elseif out.stderr and out.stderr ~= "" then
			notify("Chezmoi apply failed: " .. out.stderr, vim.log.levels.ERROR)
			return
		end
		notify("Chezmoi apply failed", vim.log.levels.ERROR)
	end
end
