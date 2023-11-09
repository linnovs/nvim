local sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }
local ia_sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }

local function insert(position, component)
	local pos = "lualine_" .. position
	table.insert(sections[pos], component)
end

local mode = require("kuuga.config.statusline.mode")
local noice = require("kuuga.config.statusline.noice")
local lsp = require("kuuga.config.statusline.lsp")
local git = require("kuuga.config.statusline.git")
local file = require("kuuga.config.statusline.file")
local lazy_updates = require("kuuga.config.statusline.updates")

-- available position are a,b,c,x,y,z
insert("b", mode.bar)
insert("b", mode.icon)
insert("b", noice.marco)
insert("b", lsp.client_names)
insert("b", git.branch)
insert("b", git.diff)
insert("c", file.icon)
insert("c", file.name)
insert("x", lazy_updates)
insert("x", file.encoding)
insert("x", file.format)
insert("x", file.type)
insert("y", lsp.diagnostics)
insert("y", file.location)

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = { " ", " " },
		section_separators = { " ", " " },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = sections,
	inactive_sections = ia_sections,
	tabline = {},
	extensions = { "neo-tree", "quickfix", "trouble", "man", "lazy" },
})
