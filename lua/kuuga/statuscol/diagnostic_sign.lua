local icons = require("kuuga.lib.icons").diagnostics
local severity_hl = {
	[vim.diagnostic.severity.ERROR] = "%#DiagnosticError#",
	[vim.diagnostic.severity.WARN] = "%#DiagnosticWarn#",
	[vim.diagnostic.severity.INFO] = "%#DiagnosticInfo#",
	[vim.diagnostic.severity.HINT] = "%#DiagnosticHint#",
}
local severity_map = {
	[vim.diagnostic.severity.ERROR] = "error",
	[vim.diagnostic.severity.WARN] = "warn",
	[vim.diagnostic.severity.INFO] = "info",
	[vim.diagnostic.severity.HINT] = "hint",
}

---@param bufnr number
local function get_diagnostic_sign(bufnr)
	local diagnostices = vim.diagnostic.get(bufnr, { lnum = vim.v.lnum - 1 })
	if #diagnostices == 0 then return nil end

	local diagnostic = diagnostices[1]
	local severity = diagnostic.severity
	local hl = severity_hl[severity] or ""

	return hl .. icons[severity_map[severity]] .. " %*"
end

return function()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local diagnostic_sign = get_diagnostic_sign(bufnr)
	return (diagnostic_sign or " ") .. " "
end
