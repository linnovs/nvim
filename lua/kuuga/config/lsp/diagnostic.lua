local keymap = require("kuuga.lib.keymap")
local icons = require("kuuga.lib.icons")

---@param cursor boolean
local function diagnostic_open_float(cursor)
	---@type vim.diagnostic.Opts.Float
	local diag_opts = {
		focusable = false,
		-- close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
		border = "rounded",
		source = true,
		prefix = " ",
		scope = cursor and "cursor" or "line",
	}

	return function() vim.diagnostic.open_float(diag_opts) end
end

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
			[vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
			[vim.diagnostic.severity.INFO] = icons.diagnostics.info,
			[vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		},
	},
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

keymap.map("n", "<leader>d", diagnostic_open_float(false), "Show diagnostic floating window")
keymap.map("n", "<leader>q", vim.diagnostic.setloclist, "Add buffer diagnostics to location list")
