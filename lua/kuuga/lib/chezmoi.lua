local homedir = os.getenv("HOME")
local uv = vim.uv

local function notify(msg, level)
	vim.schedule(function() vim.notify(msg, level, { title = "Chezmoi", timeout = 2000 }) end)
end

--- @param args vim.api.keyset.create_autocmd.callback_args
return function(args)
	local file = args.file:match("^.+/(.+)$") or args.file
	local is_run = string.sub(file, 1, string.len("run_")) == "run_"
	local is_chezmoi = string.sub(file, 1, string.len(".chezmoi")) == ".chezmoi"

	if is_run or is_chezmoi then return end

	local stdin = uv.new_pipe()
	local stdout = uv.new_pipe()

	if stdin == nil or stdout == nil then
		notify("Failed to create pipes for child process", vim.log.levels.ERROR)
		return
	end

	uv.spawn("chezmoi", {
		args = { "apply", "--no-pager", "--no-tty", "--refresh-externals=never", "--source-path", args.file },
		stdio = { stdin, stdout, nil },
		cwd = homedir .. "/.local/share/chezmoi",
	}, function(code)
		if code ~= 0 then
			if stdout == nil then
				notify("Apply failed with code: " .. code, vim.log.levels.ERROR)
				return
			end
			uv.read_start(stdout, function(err, data)
				if err then
					notify("Error reading stdout: " .. err, vim.log.levels.ERROR)
					return
				end
				if data then
					notify("Apply failed: " .. data, vim.log.levels.ERROR)
				else
					notify("Apply failed with code: " .. code, vim.log.levels.ERROR)
				end
			end)
		else
			notify("Chezmoi apply successful", vim.log.levels.INFO)
		end
	end)

	uv.write(stdin, "diff\n")
	uv.shutdown(stdin)
end
