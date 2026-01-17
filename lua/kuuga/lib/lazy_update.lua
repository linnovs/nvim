local AFTER_UPDATE = {}

local uv = vim.uv
local configPath = vim.fn.stdpath("config")
local commitMsg = "chore(lazy): update lazy-lock.json"

local notify = function(msg, level) vim.notify(msg, level, { title = "Lazy" }) end

local notifyError = function(msg) notify(msg, vim.log.levels.ERROR) end

local notifyInfo = function(msg) notify(msg, vim.log.levels.INFO) end

local amendLastCommit = function()
	uv.spawn("git", { cwd = configPath, args = { "commit", "--amend", "--no-edit" } }, function(status)
		if status == 0 then
			notifyInfo("Amended last chore commit")
		else
			notifyError("Failed to amend lazy-lock.json: " .. status)
		end
	end)
end

local newCommit = function()
	uv.spawn("git", { cwd = configPath, args = { "commit", "-m", commitMsg } }, function(status)
		if status == 0 then
			notifyInfo("Committed lazy-lock.json")
		else
			notifyError("Failed to commit lazy-lock.json: " .. status)
		end
	end)
end

local handleLatestLog = function(resultPipe)
	uv.spawn("grep", {
		args = { "-q", commitMsg },
		stdio = { resultPipe, nil, nil },
	}, function(status)
		if status == 0 then return amendLastCommit() end

		newCommit()
	end)
end

local handleAfterAdd = function(status)
	if status ~= 0 then
		notifyError("Failed to add lazy-lock.json: " .. status)
		return
	end

	local stdout = uv.new_pipe()

	uv.spawn("git", {
		cwd = configPath,
		args = { "log", "-1", "--pretty=format:%B" },
		stdio = { nil, stdout, nil },
	}, function(logStatusCode)
		if logStatusCode ~= 0 then
			notifyError("Failed to get last commit message: " .. logStatusCode)
			return
		end

		handleLatestLog(stdout)
	end)
end

AFTER_UPDATE.callback = function()
	uv.spawn("git", { cwd = configPath, args = { "add", "lazy-lock.json" } }, handleAfterAdd)
end

return AFTER_UPDATE
