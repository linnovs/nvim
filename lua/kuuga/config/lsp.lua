local M = {}

if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("trace")
end

local builtin = require("telescope.builtin")

M.format_filter = {}

function M.disable_format(name)
	M.format_filter[name] = true
end

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "Show diagnostic floating window" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Move to the previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Move to the next diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Add buffer diagnostics to location list" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("KuugaLspConfig", {}),
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		if client == nil then
			return
		end

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

		autocmd("CursorHold", {
			group = augroup("LspShowDiagnostic" .. bufnr, { clear = true }),
			buffer = bufnr,
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "rounded",
					source = "always",
					prefix = " ",
					scope = "cursor",
				}

				vim.diagnostic.open_float(nil, opts)
			end,
		})

		if client.supports_method("textDocument/codeAction") then
			map("n", "<Leader>ca", vim.lsp.buf.code_action, "Code action")
		end

		if client.supports_method("textDocument/formatting") then
			autocmd("BufWritePre", {
				group = augroup("LspFormat." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							return M.format_filter[c.name] ~= true
						end,
						bufnr = bufnr,
					})
				end,
			})
		end

		if client.supports_method("textDocument/codeLens") then
			autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
				group = augroup("LspCodeLens." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = vim.lsp.codelens.refresh,
			})
			map("n", "<Leader>cl", vim.lsp.codelens.run, "Code lens")
		end

		if client.supports_method("textDocument/documentSymbol") then
			require("nvim-navic").attach(client, bufnr)
			require("nvim-navbuddy").attach(client, bufnr)
		end

		if client.supports_method("textDocument/signatureHelp") then
			map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")
		end

		if client.supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(bufnr, true)
		end
	end,
})

return M
