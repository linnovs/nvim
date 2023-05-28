local M = {}

if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("trace")
end

local builtin = require("telescope.builtin")

M.format_filter = {}

function M.disable_format(name)
	M.format_filter[name] = true
end

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Move to the next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to location list" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("KuugaLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)

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

		if client.server_capabilities.codeActionProvider then
			map("n", "<Leader>cam", vim.lsp.buf.code_action, "Code action")
		end

		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						filter = function(c)
							return M.format_filter[c.name] ~= true
						end,
						bufnr = bufnr,
					})
				end,
			})
		end

		if client.server_capabilities.codeLensProvider then
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
				group = vim.api.nvim_create_augroup("LspCodeLens." .. bufnr .. "." .. client.name, { clear = true }),
				buffer = bufnr,
				callback = vim.lsp.codelens.refresh,
			})
			map("n", "<Leader>cl", vim.lsp.codelens.run, "Code lens")
		end

		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
			require("nvim-navbuddy").attach(client, bufnr)
		end

		if client.server_capabilities.signatureHelpProvider then
			map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		end

		require("lsp-inlayhints").on_attach(client, bufnr)
	end,
})

return M
