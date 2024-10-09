local M = {}

---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param desc string
---@param opts? vim.keymap.set.Opts
function M.map(mode, lhs, rhs, desc, opts)
	if opts == nil then
		opts = {
			desc = desc,
		}
	else
		opts["desc"] = desc
	end

	vim.keymap.set(mode, lhs, rhs, opts)
end

return M
