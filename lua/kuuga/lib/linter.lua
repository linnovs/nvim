local M = {}
local lint_exists, lint = pcall(require, "lint")

---@param linters string[]
function M.setup(linters)
	if not lint_exists then return end
	lint.linters_by_ft[vim.bo.filetype] = linters
end

return M
