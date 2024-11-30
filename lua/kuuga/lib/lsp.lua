local M = {}

local keymap = require("kuuga.lib.keymap")
local builtin = require("telescope.builtin")

if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.set_log_level("trace")
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

	return function()
		vim.diagnostic.open_float(diag_opts)
	end
end

M.setup = function()
	keymap.map("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic floating window")
	keymap.map("n", "<leader>q", vim.diagnostic.setloclist, "Add buffer diagnostics to location list")

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("KuugaLspConfig", { clear = false }),
		callback = function(ev)
			local bufnr = ev.buf
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local augroup = vim.api.nvim_create_augroup
			local autocmd = vim.api.nvim_create_autocmd

			local function map(lhs, rhs, desc)
				keymap.map("n", lhs, rhs, desc, { buffer = bufnr })
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
				callback = diagnostic_open_float(true),
			})

			if client.supports_method("textDocument/codeAction") then
				map("<Leader>ca", vim.lsp.buf.code_action, "Code action")
			end

			if client.supports_method("textDocument/codeLens") then
				autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
					group = augroup("LspCodeLens." .. bufnr, { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.codelens.refresh({ bufnr = bufnr })
					end,
				})
				map("<Leader>cl", vim.lsp.codelens.run, "Code lens")
			end
		end,
	})
end

function M.lsp_progress_autocmd()
	---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
	local progress = vim.defaulttable()
	vim.api.nvim_create_autocmd("LspProgress", {
		---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
		callback = function(ev)
			local client = vim.lsp.get_client_by_id(ev.data.client_id)
			local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
			if not client or type(value) ~= "table" then
				return
			end
			local p = progress[client.id]

			for i = 1, #p + 1 do
				if i == #p + 1 or p[i].token == ev.data.params.token then
					p[i] = {
						token = ev.data.params.token,
						msg = ("[%3d%%] %s%s"):format(
							value.kind == "end" and 100 or value.percentage or 100,
							value.title or "",
							value.message and (" **%s**"):format(value.message) or ""
						),
						done = value.kind == "end",
					}
					break
				end
			end

			local msg = {} ---@type string[]
			progress[client.id] = vim.tbl_filter(function(v)
				return table.insert(msg, v.msg) or not v.done
			end, p)

			local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
			vim.notify(table.concat(msg, "\n"), "info", {
				id = "lsp_progress",
				title = client.name,
				opts = function(notif)
					notif.icon = #progress[client.id] == 0 and " "
						or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
				end,
			})
		end,
	})
end

return M
