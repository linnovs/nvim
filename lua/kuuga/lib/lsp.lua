local M = {}

local keymap = require("kuuga.lib.keymap")
local fzf = require("fzf-lua")

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

	return function()
		vim.diagnostic.open_float(diag_opts)
	end
end

local function declaration()
	fzf.lsp_declarations({ jump_to_single_result = true })
end

local function definitions()
	fzf.lsp_definitions({ jump_to_single_result = true })
end

local function implementations()
	fzf.lsp_implementations({ jump_to_single_result = true })
end

local function hover()
	vim.lsp.buf.hover()
end

local function rename()
	vim.lsp.buf.rename()
end

local function typedefs()
	fzf.lsp_typedefs({ jump_to_single_result = true })
end

local function references()
	fzf.lsp_references({ jump_to_single_result = true })
end

local function codeaction()
	vim.lsp.buf.code_action()
end

local function codelens()
	vim.lsp.codelens.run()
end

M.setup = function()
	keymap.map("n", "<leader>d", diagnostic_open_float(false), "Show diagnostic floating window")
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

			map("gD", declaration, "Go to declaration")
			map("gd", definitions, "Go to definitions")
			map("gi", implementations, "Go to implementations")
			map("K", hover, "Hover")
			map("<Leader>rn", rename, "Rename")
			map("<Leader>D", typedefs, "Type definitions")
			map("gr", references, "References")

			autocmd("CursorHold", {
				group = augroup("LspShowDiagnostic" .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = diagnostic_open_float(true),
			})

			if client:supports_method("textDocument/codeAction", bufnr) then
				map("<Leader>ca", codeaction, "Code action")
			end

			if client:supports_method("textDocument/codeLens", bufnr) then
				autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
					group = augroup("LspCodeLens." .. bufnr, { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.codelens.refresh({ bufnr = bufnr })
					end,
				})
				map("<Leader>cl", codelens, "Code lens")
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
