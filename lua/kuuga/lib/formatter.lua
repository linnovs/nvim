local M = {}
local conform_exists, conform = pcall(require, "conform")

---@param formatters conform.FiletypeFormatter
function M.setup(formatters)
	if not conform_exists then return end
	conform.formatters_by_ft[vim.bo.filetype] = formatters
end

return M
