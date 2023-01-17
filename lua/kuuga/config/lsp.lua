local M = {}

local builtin = require("telescope.builtin")

M.on_attach = function(client, bufnr)
	-- enable completion
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local function map(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
	end

	map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
	map("n", "gd", builtin.lsp_definitions, "Go to definitions")
	map("n", "gi", builtin.lsp_implementations, "Go to implementations")
	map("n", "K", vim.lsp.buf.hover, "Hover")
	map("n", "<Leader>rn", vim.lsp.buf.rename, "Rename")
	map("n", "<Leader>D", builtin.lsp_type_definitions, "Type definitions")
	map("n", "gr", builtin.lsp_references, "References")
	map("n", "<Leader>ds", builtin.lsp_document_symbols, "Document symbols")

	if client.server_capabilities.codeActionProvider then
		map("n", "<Leader>cam", ":CodeActionMenu<CR>", "Code action")
	end

	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({
					filter = function(c)
						return c.name ~= "volar"
					end,
				})
			end,
		})
	end

	if client.server_capabilities.codeLensProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("LspCodeLens." .. bufnr, {}),
			buffer = bufnr,
			callback = vim.lsp.codelens.refresh,
		})
		map("n", "<Leader>cl", vim.lsp.codelens.run, "Code lens")
	end

	if client.server_capabilities.documentSymbolProvider then
		require("nvim-navic").attach(client, bufnr)
	end

	if client.server_capabilities.signatureHelpProvider then
		map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		require("lsp_signature").on_attach()
	end
end

return M
