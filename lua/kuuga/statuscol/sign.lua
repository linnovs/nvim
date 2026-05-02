local icons = require("kuuga.lib.icons").diagnostics
local severity_hl = {
	[vim.diagnostic.severity.ERROR] = "%#DiagnosticError#",
	[vim.diagnostic.severity.WARN] = "%#DiagnosticWarn#",
	[vim.diagnostic.severity.INFO] = "%#DiagnosticInfo#",
	[vim.diagnostic.severity.HINT] = "%#DiagnosticHint#",
}

---@param bufnr number
local function get_diagnostic_sign(bufnr)
	local diagnostic = vim.diagnostic.get(bufnr, { lnum = vim.v.lnum - 1 })[1]

	if not diagnostic then return " " end

	local severity = diagnostic.severity
	local hl = severity_hl[severity] or ""

	return hl .. icons[severity] .. " %*"
end

return function()
	local winid = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local git_sign = require("gitsigns").statuscolumn(bufnr)
	local diagnostic_sign = get_diagnostic_sign(bufnr)
	return (diagnostic_sign or git_sign or " ") .. " "
end
