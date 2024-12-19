local sections = { lualine_a = {}, lualine_b = {}, lualine_c = {}, lualine_x = {}, lualine_y = {}, lualine_z = {} }

local function insert_left(component)
	table.insert(sections.lualine_c, component)
end

local function insert_right(component)
	table.insert(sections.lualine_x, component)
end

local components = require("kuuga.lib.statusline.lualine.components")

insert_left(components.mode)
insert_left(components.macro)
insert_left(components.fileicon)
insert_left(components.filename)
insert_left(components.diagnostic)

insert_right(components.lazy_update)
insert_right(components.empty)
insert_right(components.filetype)
insert_right(components.ruler)
insert_right(components.selectioncount)
insert_right(components.progress)

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "catppuccin",
		component_separators = "",
		section_separators = "",
		disabled_filetypes = {
			statusline = {
				"dashboard",
			},
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = sections,
	extensions = {
		"lazy",
		"man",
		"mason",
		"nvim-dap-ui",
		"oil",
		"quickfix",
		"toggleterm",
		"trouble",
	},
})
