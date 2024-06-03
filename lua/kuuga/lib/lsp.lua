local M = {}

local keymap = require("kuuga.lib.keymap")
local builtin = require("telescope.builtin")

if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("trace")
end

M.setup = function()
	keymap("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic floating window")
	keymap("n", "<leader>q", vim.diagnostic.setloclist, "Add buffer diagnostics to location list")

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("KuugaLspConfig", { clear = false }),
		callback = function(ev)
			local bufnr = ev.buf
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd

			local function map(lhs, rhs, desc)
				keymap("n", lhs, rhs, desc, { buffer = bufnr })
			end

			if client == nil then
				return
			end

			map("gD", vim.lsp.buf.declaration, "Go to declaration")
			map("gd", builtin.lsp_definitions, "Go to definitions")
			map("gi", builtin.lsp_implementations, "Go to implementations")
			map("K", vim.lsp.buf.hover, "Hover")
			map("<Leader>rn", vim.lsp.buf.rename, "Rename")
			map("<Leader>D", builtin.lsp_type_definitions, "Type definitions")
			map("gr", builtin.lsp_references, "References")

			autocmd("CursorHold", {
				group = augroup("LspShowDiagnostic" .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function()
					local diag_opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",
						source = "always",
						prefix = " ",
						scope = "cursor",
					}

					vim.diagnostic.open_float(nil, diag_opts)
				end,
			})

			if client.supports_method("textDocument/codeAction") then
				map("<Leader>ca", vim.lsp.buf.code_action, "Code action")
			end

			if client.supports_method("textDocument/codeLens") then
				autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
					group = augroup("LspCodeLens." .. bufnr, { clear = true }),
					buffer = bufnr,
					callback = vim.lsp.codelens.refresh,
				})
				map("<Leader>cl", vim.lsp.codelens.run, "Code lens")
			end

			if client.supports_method("textDocument/documentSymbol") then
				require("nvim-navic").attach(client, bufnr)
				require("nvim-navbuddy").attach(client, bufnr)
			end

			if client.supports_method("textDocument/inlayHint") then
				map("yoih", function()
					vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled())
				end, "Toggle inlay hints")
			end
		end,
	})
end

return M
