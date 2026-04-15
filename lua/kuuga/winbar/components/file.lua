local file_lib = require("kuuga.lib.file")

---@param active boolean
return function(active)
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = file_lib.get_filename(bufnr)
	local icon, hl = file_lib.get_file_icon(filename)

	return table.concat({
		active and "%$" .. hl .. "$" or "",
		icon .. " ",
		"%$WinBarFile$",
		filename,
		" ",
	})
end
