local git_lib = require("kuuga.statusline.components.git_lib")

return function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local branch = git_lib.get_branch(bufnr)

	if branch == nil then return "" end

	return table.concat({
		"%#StatusLineGitBranchIcon# ",
		"%#StatusLineGitBranchName#" .. branch,
	})
end
