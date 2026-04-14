local icons = require("kuuga.lib.icons").diagnostics
local keymap = require("kuuga.lib.keymap")

local function diagnostic_open_float()
	---@type vim.diagnostic.Opts.Float
	local diag_opts = {
		border = "rounded",
		header = "",
		source = true,
		scope = "line",
	}

	return function() vim.diagnostic.open_float(diag_opts) end
end

vim.diagnostic.config({
	virtual_lines = false,
	virtual_text = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = icons.error,
			[vim.diagnostic.severity.WARN] = icons.warn,
			[vim.diagnostic.severity.INFO] = icons.info,
			[vim.diagnostic.severity.HINT] = icons.hint,
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

keymap("n", "<Leader>d", diagnostic_open_float(), "Open diagnostic popup")
keymap("n", "<Leader>q", function() vim.diagnostic.setloclist() end, "Add buffer diagnostics to location list")
