local function get_diagnostic_counts()
	return vim.diagnostic.count(nil, { severity = { min = vim.diagnostic.severity.HINT } })
end

return function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local diagnostics = get_diagnostic_counts()

	local results = {
		errors = diagnostics[vim.diagnostic.severity.ERROR] or 0,
		warnings = diagnostics[vim.diagnostic.severity.WARN] or 0,
		info = diagnostics[vim.diagnostic.severity.INFO] or 0,
		hints = diagnostics[vim.diagnostic.severity.HINT] or 0,
	}
	local total = results.errors + results.warnings + results.info + results.hints

	if vim.bo[bufnr].modifiable and total > 0 then
		local msgs = {}

		if results.errors > 0 then table.insert(msgs, "%#DiagnosticError# %*" .. results.errors) end
		if results.warnings > 0 then table.insert(msgs, "%#DiagnosticWarn# %*" .. results.warnings) end
		if results.info > 0 then table.insert(msgs, "%#DiagnosticInfo# %*" .. results.info) end
		if results.hints > 0 then table.insert(msgs, "%#DiagnosticHint# %*" .. results.hints) end

		return table.concat(msgs, " ")
	end

	return ""
end
