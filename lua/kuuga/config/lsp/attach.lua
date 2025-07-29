local keymap = require("kuuga.lib.keymap")

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		local function map(lhs, rhs, desc, mode)
			if not mode then mode = "n" end
			keymap.map(mode, lhs, rhs, desc, { buffer = bufnr })
		end

		if client == nil then return end

		map("gd", function() Snacks.picker.lsp_definitions() end, "Go to definitions")
		map("gD", function() Snacks.picker.lsp_declarations() end, "Go to declaration")
		map("grr", function() Snacks.picker.lsp_references() end, "References")
		map("gri", function() Snacks.picker.lsp_implementations() end, "Go to implementations")
		map("grt", function() Snacks.picker.lsp_type_definitions() end, "Type definitions")
		map("<Leader>fs", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
		map("<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")

		if client:supports_method("textDocument/codeLens", bufnr) then
			autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
				group = augroup("LspCodeLens." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
			})
			map("<Leader>cl", function() vim.lsp.codelens.run() end, "Code lens")
		end
	end,
})
