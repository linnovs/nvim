local branch_cache = setmetatable({}, { __mode = "k" })

local function git_cmd(...)
	local root = vim.fs.root(0, ".git")
	local job = vim.system({ "git", "-C", root, ... }):wait()

	if job.code ~= 0 then return nil, job.stderr end

	return vim.trim(job.stdout)
end

local function git_branch(root)
	if branch_cache[root] then return branch_cache[root] end

	local out = git_cmd("rev-parse", "--abbrev-ref", "HEAD")
	if out == "HEAD" then
		local commit = git_cmd("rev-parse", "--short", "HEAD")
		commit = "%#Comment#(" .. commit .. ")%*"
		out = string.format("%s %s", out, commit)
	end

	branch_cache[root] = out

	return out
end

return function()
	local root = vim.fs.root(0, ".git")
	if not root then return "" end

	local branch = git_branch(root)

	return table.concat({
		"%#StatuslineGitBranchIcon# ",
		"%#StatuslineGitBranchName#" .. branch,
	})
end
