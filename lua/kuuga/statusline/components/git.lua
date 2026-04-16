local git_lib = require("kuuga.statusline.components.git_lib")

---@param winid integer
return function(winid)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local branch = git_lib.get_branch(bufnr)

	if branch == nil then return "" end

	return table.concat({
		"%#StatusLineGitBranchIcon# ",
		"%#StatusLineGitBranchName#" .. branch,
	})
end
