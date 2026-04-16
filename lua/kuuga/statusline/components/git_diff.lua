local git_lib = require("kuuga.statusline.components.git_lib")

---@param winid integer
return function(winid)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local diff = git_lib.get_diff(bufnr)

	if diff == nil then return "" end

	local result = {}

	if diff.added > 0 then
		table.insert(result, "%#StatusLineGitDiffAdded#" .. " %#StatusLineGitDiff#" .. diff.added)
	end
	if diff.modified > 0 then
		table.insert(result, "%#StatusLineGitDiffModified#" .. " %#StatusLineGitDiff#" .. diff.modified)
	end
	if diff.deleted > 0 then
		table.insert(result, "%#StatusLineGitDiffDeleted#" .. " %#StatusLineGitDiff#" .. diff.deleted)
	end

	return table.concat(result, " ")
end
