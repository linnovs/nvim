local sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }
local ia_sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }

local function insert(position, component)
	local pos = "lualine_" .. position
	table.insert(sections[pos], component)
end

local lsp = require("nebula.plugin.statusline.lualine.lsp")
local git = require("nebula.plugin.statusline.lualine.git")
local file = require("nebula.plugin.statusline.lualine.file")
local gps = require("nebula.plugin.statusline.lualine.gps")

-- available position are a,b,c,x,y,z
insert("a", { "mode" })
insert("b", lsp.client_names)
insert("b", git.branch)
insert("b", git.diff)
insert("c", file.icon)
insert("c", file.name)
insert("c", gps)
insert("x", file.encoding)
insert("x", file.format)
insert("x", file.type)
insert("y", lsp.diagnostics)
insert("z", file.location)

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { " ", " " },
		section_separators = { " ", " " },
		disabled_filetypes = { "packer" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = sections,
	inactive_sections = ia_sections,
	tabline = {},
	extensions = { "nvim-tree", "quickfix" },
})
