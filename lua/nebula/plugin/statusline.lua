local lsp = require("feline.providers.lsp")
local vi_mode_utils = require("feline.providers.vi_mode")

local fn = vim.fn

local force_inactive = {
	filetypes = {
		"NvimTree",
		"packer",
		"startify",
		"fugitive",
		"fugitiveblame",
		"qf",
		"help",
	},
	buftypes = {
		"terminal",
	},
	bufnames = {},
}

local components = {
	active = {},
	inactive = {},
}

local vi_mode_text = {
	n = "NORMAL",
	i = "INSERT",
	v = "VISUAL",
	[""] = "V-BLOCK",
	V = "V-LINE",
	c = "COMMAND",
	no = "UNKNOWN",
	s = "UNKNOWN",
	S = "UNKNOWN",
	ic = "UNKNOWN",
	R = "REPLACE",
	Rv = "UNKNOWN",
	cv = "UNKWON",
	ce = "UNKNOWN",
	r = "REPLACE",
	rm = "UNKNOWN",
	t = "INSERT",
}

local gps = require("nvim-gps")

gps.setup({
	icons = {
		["class-name"] = " ", -- Classes and class-like objects
		["function-name"] = " ", -- Functions
		["method-name"] = " ", -- Methods (functions inside class-like objects)
	},
	separator = " > ",
})

table.insert(components.active, {
	{
		provider = function()
			return " " .. vi_mode_text[fn.mode()] .. " "
		end,
		hl = function()
			return {
				name = vi_mode_utils.get_mode_highlight_name(),
				fg = "bg",
				bg = vi_mode_utils.get_mode_color(),
				style = "bold",
			}
		end,
	},
	{
		provider = "file_info",
		hl = {
			fg = "fg",
			bg = "bg",
			style = "bold",
		},
		file_modified_icon = "️️🐧",
		type = "unique",
		left_sep = " ",
	},
	{
		provider = "file_size",
		enabled = function()
			return fn.getfsize(fn.expand("%:p")) > 0
		end,
		right_sep = " ",
	},
	{
		provider = function()
			return gps.get_location()
		end,
		enabled = function()
			return gps.is_available()
		end,
		right_sep = " ",
	},
	{
		provider = "git_branch",
		hl = {
			fg = "yellow",
			bg = "bg",
			style = "bold",
		},
	},
	{
		provider = "git_diff_added",
		hl = {
			fg = "green",
			bg = "bg",
		},
	},
	{
		provider = "git_diff_changed",
		hl = {
			fg = "orange",
			bg = "bg",
		},
	},
	{
		provider = "git_diff_removed",
		hl = {
			fg = "red",
			bg = "bg",
		},
	},
})

table.insert(components.active, {
	{
		provider = "diagnostic_errors",
		enabled = function()
			return lsp.diagnostics_exist("Error")
		end,
		hl = { fg = "red" },
	},
	{
		provider = "diagnostic_warnings",
		enabled = function()
			return lsp.diagnostics_exist("Warning")
		end,
		hl = { fg = "yellow" },
	},
	{
		provider = "diagnostic_hints",
		enabled = function()
			return lsp.diagnostics_exist("Hint")
		end,
		hl = { fg = "cyan" },
	},
	{
		provider = "diagnostic_info",
		enabled = function()
			return lsp.diagnostics_exist("Information")
		end,
		hl = { fg = "skyblue" },
	},
	{
		provider = function()
			return string.format("%d:%d", fn.line("."), fn.col("."))
		end,
		left_sep = " ",
		right_sep = " |",
	},
	{
		provider = "line_percentage",
		hl = {
			style = "bold",
		},
		left_sep = " ",
		right_sep = " ",
	},
	{
		provider = "scroll_bar",
		hl = {
			fg = "skyblue",
			style = "bold",
		},
	},
})

table.insert(components.inactive, {
	{
		provider = "file_type",
		hl = {
			fg = "bg",
			bg = "oceanblue",
			style = "bold",
		},
		right_sep = {
			{
				str = " ",
				hl = {
					fg = "NONE",
					bg = "oceanblue",
				},
			},
			{
				str = " ",
				hl = {
					fg = "NONE",
					bg = "bg",
				},
			},
		},
	},
	{
		provider = "file_info",
		hl = {
			fg = "fg",
			bg = "bg",
			style = "bold",
		},
		type = "unique",
		left_sep = " ",
	},
})

-- Nord theme colors
local colors = {
	fg = "#D8DEE9",
	nord0 = "#2E3440",
	bg = "#3B4252",
	black = "#434C5E",
	nord3 = "#4C566A",
	white = "#E5E9F0",
	nord6 = "#ECEFF4",
	oceanblue = "#8FBCBB",
	skyblue = "#88C0D0",
	nord9 = "#81A1C1",
	cyan = "#5E81AC",
	red = "#BF616A",
	orange = "#D08770",
	yellow = "#EBCB8B",
	green = "#A3BE8C",
	violet = "#B48EAD",
	magenta = "#B48EAD",
}

require("feline").setup({
	colors = colors,
	components = components,
	force_inactive = force_inactive,
})
