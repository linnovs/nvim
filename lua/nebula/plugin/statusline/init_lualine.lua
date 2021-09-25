local config = {
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { "|", "|" },
		section_separators = { " ", " " },
		disabled_filetypes = { "packer" },
	},
	sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} },
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "quickfix" },
}
local function parse_section(part)
	local section = "lualine_a"

	if type(part) == "string" then
		section = string.format("lualine_%s", part:match("[abcxyz]"))
	end

	return section
end

local function insert_active(part, component)
	local components = config.sections[parse_section(part)]
	table.insert(components, component)
end

local function insert_inactive(part, component)
	local components = config.inactive_sections[parse_section(part)]
	table.insert(components, component)
end

local function get_active_lsp()
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return nil
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
end

local gps = require("nvim-gps")
local colors = require("nebula.colors").git

-- left side
insert_active("a", "mode")
insert_active("b", "branch")
insert_active("b", {
	"diff",
	colored = true,
	color_added = colors.added,
	color_modified = colors.modified,
	color_removed = colors.removed,
	symbols = { added = " ", modified = " ", removed = " " },
})
insert_active("b", {
	function()
		return get_active_lsp()
	end,
	condition = function()
		return get_active_lsp() ~= nil
	end,
	icon = "",
	color = { gui = "bold" },
})
insert_active("c", { "filename", file_status = true })
insert_active("c", { gps.get_location, condition = gps.is_available })
insert_inactive("c", { "filename", file_status = true })

-- right side
insert_active("x", "encoding")
insert_active("x", "fileformat")
insert_active("x", "filetype")
insert_active("y", {
	"diagnostics",
	sources = { "nvim_lsp" },
	sections = { "error", "warn", "info", "hint" },
	symbols = { error = " ", warn = " ", info = " ", hint = " " },
})
insert_active("z", "location")
insert_inactive("x", "location")

require("lualine").setup(config)
