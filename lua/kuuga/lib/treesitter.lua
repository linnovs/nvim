local M = {}

local max_filesize = 100 * 1024 -- 100 KiB
local has_TS, TS = pcall(require, "nvim-treesitter")
local installed_langs = has_TS and TS.get_installed() or {}

function M.start()
	local ftype = vim.bo.filetype
	local bufnr = vim.api.nvim_get_current_buf()
	local lang = vim.treesitter.language.get_lang(ftype)
	if not lang then return end
	if not vim.tbl_contains(installed_langs, lang) then
		if has_TS then TS.install({ lang }) end
	end

	local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(bufnr))
	if stat and stat.size < max_filesize then vim.treesitter.start() end

	vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	vim.wo.foldmethod = "expr"
end

return M
