local keymap = require("kuuga.lib.keymap")

local function declaration() Snacks.picker.lsp_declarations() end

local function definitions() Snacks.picker.lsp_definitions() end

local function implementations() Snacks.picker.lsp_implementations() end

local function hover() vim.lsp.buf.hover() end

local function rename() vim.lsp.buf.rename() end

local function typedefs() Snacks.picker.lsp_type_definitions() end

local function references() Snacks.picker.lsp_references() end

local function codeaction() vim.lsp.buf.code_action() end

local function codelens() vim.lsp.codelens.run() end

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
