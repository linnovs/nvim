local M = {}
local augroup = vim.api.nvim_create_augroup("KuugaLazyFileType", { clear = true })

---@param callback fun(vim.api.keyset.create_autocmd.callback_args)
---@param opts? vim.api.keyset.create_autocmd
function M.autocmd(callback, opts)
	opts = opts or {}

	return vim.api.nvim_create_autocmd(
		"FileType",
		vim.tbl_extend("force", {
			group = augroup,
			once = true,
			---@param ev vim.api.keyset.create_autocmd.callback_args
			callback = function(ev)
				callback(ev)

				vim.schedule(function()
					local bufnr = ev.buf
					if not vim.api.nvim_buf_is_valid(bufnr) then return end

					local _opts = { buffer = bufnr, modeline = false }

					vim.api.nvim_exec_autocmds("BufReadPre", _opts)
					vim.api.nvim_exec_autocmds("BufReadPost", _opts)
					vim.api.nvim_exec_autocmds("FileType", _opts)
				end)
			end,
		}, opts)
	)
end

return M
