local api = vim.api
local devicons = require("nvim-web-devicons")

local function get_file_icon(filename)
	local icon, hl = devicons.get_icon(filename, nil, { default = true })

	return "%#" .. hl .. "#" .. icon .. "%* "
end

local function is_modified(bufnr)
	local bo = vim.bo[bufnr]
	return bo.modified
end

local function is_readonly(bufnr)
	local bo = vim.bo[bufnr]
	return bo.readonly
end

local buftype_ignore = { "acwrite", "prompt" }

return function()
	local bufnr = api.nvim_win_get_buf(vim.g.statusline_winid)
	local filepath = api.nvim_buf_get_name(bufnr)
	local bo = vim.bo[bufnr]

	if bo.buftype ~= "" and not vim.tbl_contains(buftype_ignore, bo.buftype) then filepath = bo.buftype end

	local filename = vim.fs.basename(filepath)
	local icon = get_file_icon(filename)

	return table.concat({
		icon,
		"%#StatuslineFile#",
		filename,
		"%#StatuslineFileModified#",
		is_modified(bufnr) and " " or "",
		"%#StatuslineFileReadonly#",
		is_readonly(bufnr) and " " or "",
	})
end
