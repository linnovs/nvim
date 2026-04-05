if vim.env.VIMDEBUG == "lsp" then
	vim.lsp.log.set_level(vim.log.levels.DEBUG)
else
	vim.lsp.log.set_level(vim.log.levels.ERROR)
end

vim.api.nvim_create_user_command("LspInfo", "checkhealth vim.lsp", { desc = "Show LSP Info" })
vim.api.nvim_create_user_command("LspRestart", "lsp restart", { desc = "Restart LSP" })

vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(ev)
        local value = ev.data.params.value or {}
        local msg = value.message or "done"

        if #msg > 40 then
            msg = msg:sub(1, 37) .. "..."
        end

        vim.api.nvim_echo({ { msg } }, false, {
            id = "lsp." .. ev.data.client_id,
            kind = "progress",
            title = value.title,
            status = value.kind ~= "end" and "running" or "success",
            percent = value.percentage,
        })
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local bufnr = ev.buf
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local augroup = vim.api.nvim_create_augroup
		local autocmd = vim.api.nvim_create_autocmd

		if client == nil or Snacks == nil then return end

		if client:supports_method("textDocument/codeLens", bufnr) then
			autocmd({ "CursorHold", "CursorHoldI", "InsertLeave" }, {
				group = augroup("LspCodeLens." .. bufnr, { clear = true }),
				buffer = bufnr,
				callback = function() vim.lsp.codelens.refresh({ bufnr = bufnr }) end,
			})
		end

		local function map(lhs, rhs, desc, mode)
			if not mode then mode = "n" end
			require("kuuga.lib.keymap")(mode, lhs, rhs, desc, { buffer = bufnr })
		end

		map("gd", function() Snacks.picker.lsp_definitions() end, "Go to definitions")
		map("gD", function() Snacks.picker.lsp_declarations() end, "Go to declaration")
		map("grr", function() Snacks.picker.lsp_references() end, "References")
		map("gri", function() Snacks.picker.lsp_implementations() end, "Go to implementations")
		map("grt", function() Snacks.picker.lsp_type_definitions() end, "Type definitions")
		map("gai", function() Snacks.picker.lsp_incoming_calls() end, "Callers (incoming calls)")
		map("gao", function() Snacks.picker.lsp_outgoing_calls() end, "Callers (outgoing calls)")
		map("<Leader>fs", function() Snacks.picker.lsp_symbols() end, "LSP Symbols")
		map("<leader>fS", function() Snacks.picker.lsp_workspace_symbols() end, "LSP Workspace Symbols")
	end,
})
