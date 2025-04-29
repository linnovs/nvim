local keymap = require("kuuga.lib.keymap")

if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("debug")
else
	vim.lsp.set_log_level("off")
end

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

local function declaration() Snacks.picker.lsp_declarations() end

local function definitions() Snacks.picker.lsp_definitions() end

local function implementations() Snacks.picker.lsp_implementations() end

local function hover() vim.lsp.buf.hover() end

local function rename() vim.lsp.buf.rename() end

local function typedefs() Snacks.picker.lsp_type_definitions() end

local function references() Snacks.picker.lsp_references() end

local function codeaction() vim.lsp.buf.code_action() end

local function codelens() vim.lsp.codelens.run() end

vim.diagnostic.config({
	virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
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

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		local function map(lhs, rhs, desc) keymap.map("n", lhs, rhs, desc, { buffer = bufnr }) end

		if client == nil then return end

		map("gD", declaration, "Go to declaration")
		map("gd", definitions, "Go to definitions")
		map("gi", implementations, "Go to implementations")
		map("K", hover, "Hover")
		map("<Leader>rn", rename, "Rename")
		map("<Leader>D", typedefs, "Type definitions")
		map("gr", references, "References")

		if client:supports_method("textDocument/codeAction", bufnr) then
			map("<Leader>ca", codeaction, "Code action")
		end

		if client:supports_method("textDocument/codeLens", bufnr) then
			autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
				group = augroup("LspCodeLens." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
			})
			map("<Leader>cl", codelens, "Code lens")
		end
	end,
})
