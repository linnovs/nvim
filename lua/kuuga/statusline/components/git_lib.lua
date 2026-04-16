local Git = {}

local root_dir_cache = setmetatable({}, { __mode = "k" })
local branch_cache = setmetatable({}, { __mode = "k" })
local head_watchers = setmetatable({}, { __mode = "k" })

---@param root string
---@param ... string
local function git_cmd(root, ...)
	local job = vim.system({ "git", "-C", root, ... }):wait()

	if job.code ~= 0 then return nil, job.stderr end

	return vim.trim(job.stdout)
end

local function git_branch(root)
	local out = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
	if out == "HEAD" then
		local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
		commit = "%#Comment#(" .. commit .. ")%*"
		out = string.format("%s %s", out, commit)
	end

	return out
end

local function git_diff(root)
	local out = git_cmd(root, "--no-pager", "diff", "--no-color", "--no-ext-diff", "-U0")
	if not out then return end

	local diff_info = { added = 0, modified = 0, deleted = 0 }
	for mod_count, new_count in string.gmatch(out, "@@ %-%d+,?(%d*) %+%d+,?(%d*) @@") do
		local line_modded = tonumber(mod_count) or 1
		local line_added = tonumber(new_count) or 1

		if line_modded == 0 and line_added > 0 then
			diff_info.added = diff_info.added + line_added
		elseif line_modded > 0 and line_added == 0 then
			diff_info.deleted = diff_info.deleted + line_modded
		else
			local modded = math.min(line_modded, line_added)
			diff_info.modified = diff_info.modified + modded
			diff_info.added = diff_info.added + (line_added - modded)
			diff_info.deleted = diff_info.deleted + (line_modded - modded)
		end
	end

	return diff_info
end

---@param root string
local function get_git_dir(root)
	local isdir = vim.fn.isdirectory(root .. "/.git")
	if isdir == 0 then
		local content = vim.fn.readblob(root .. "/.git")
		if string.starts(content, "gitdir: ") then
			return vim.trim(string.sub(content, string.len("gitdir: ") + 1))
		else
			return nil
		end
	end

	return root .. "/.git"
end

local ignored_filetype = { "help" }

---@param bufnr integer
function Git.update_root(bufnr)
	local filetype = vim.bo[bufnr].filetype
	if vim.list_contains(ignored_filetype, filetype) then return end

	local filepath = vim.api.nvim_buf_get_name(bufnr)

	local root = vim.fs.root(filepath, ".git")
	if not root then return end

	root_dir_cache[bufnr] = root
	branch_cache[root] = git_branch(root)

	if not head_watchers[root] then head_watchers[root] = vim.uv.new_fs_event() end

	vim.uv.fs_event_stop(head_watchers[root])

	local git_dir = get_git_dir(root)
	if not git_dir then return end

	vim.uv.fs_event_start(
		head_watchers[root],
		git_dir .. "/HEAD",
		{},
		vim.schedule_wrap(function() Git.update_root(bufnr) end)
	)
end

---@param bufnr integer
function Git.get_branch(bufnr)
	local root = root_dir_cache[bufnr]
	if not root then return end
	if branch_cache[root] then return branch_cache[root] end
end

function Git.get_diff(bufnr)
	local root = root_dir_cache[bufnr]
	if not root then return end
	return git_diff(root)
end

function Git.setup()
	local bufnr = vim.api.nvim_get_current_buf()
	Git.update_root(bufnr)

	-- Update git directory cache on buffer enter
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function(evt) Git.update_root(evt.buf) end,
	})
end

return Git
