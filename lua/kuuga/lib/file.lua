local Filename = {}

local api = vim.api
local devicons = require("nvim-web-devicons")

---@param filename string
function Filename.get_file_icon(filename) return devicons.get_icon(filename, nil, { default = true }) end

local buftype_ignore = { "acwrite", "prompt" }

---@param bufnr integer
function Filename.get_filename(bufnr)
	local filepath = api.nvim_buf_get_name(bufnr)
	local bo = vim.bo[bufnr]

	if bo.buftype ~= "" and not vim.list_contains(buftype_ignore, bo.buftype) then filepath = bo.buftype end

	return vim.fs.basename(filepath)
end

return Filename
