local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local highlights = {
	normal = {
		bg = colors.overlay0,
		fg = colors.teal,
		gui = "bold",
	},
	visual = {
		bg = colors.overlay0,
		fg = colors.peach,
		gui = "bold",
	},
	insert = {
		bg = colors.overlay0,
		fg = colors.green,
		gui = "bold",
	},
	replace = {
		bg = colors.overlay0,
		fg = colors.red,
		gui = "bold",
	},
	commandline = {
		bg = colors.overlay0,
		fg = colors.yellow,
		gui = "bold",
	},
	terminal = {
		bg = colors.overlay0,
		fg = colors.blue,
		gui = "bold",
	},
}

local mode_color = {
	["n"] = highlights.normal, -- NORMAL
	["no"] = highlights.normal, -- OP PENDING
	["nov"] = highlights.normal, -- OP PENDING CHA
	["noV"] = highlights.normal, -- OP PENDING LINE
	["no"] = highlights.normal, -- OP PENDING BLOCK
	["niI"] = highlights.normal, -- INSERT (NORMAL)
	["niR"] = highlights.normal, -- REPLACE (NORMAL)
	["niV"] = highlights.normal, -- V REPLACE (NORMAL)
	["nt"] = highlights.normal, -- TERMINAL NORMAL
	["ntT"] = highlights.normal, -- TERMINAL (NORMAL)

	["v"] = highlights.visual, -- VISUAL
	["vs"] = highlights.visual, -- SELECT (VISUAL)
	["V"] = highlights.visual, -- V-LINE
	["Vs"] = highlights.visual, -- SELECT (V-LINE)
	[""] = highlights.visual, -- V-BLOCK
	["s"] = highlights.visual, -- SELECT (V-BLOCK)
	["s"] = highlights.visual, -- SELECT
	["S"] = highlights.visual, -- S-LINE
	[""] = highlights.visual, -- S-BLOCK

	["i"] = highlights.insert, -- INSERT
	["ic"] = highlights.insert, -- INSERT COMPL GENERIC
	["ix"] = highlights.insert, -- INSERT COMPL

	["R"] = highlights.replace, -- REPLACE
	["Rc"] = highlights.replace, -- REPLACE COMP GENERIC
	["Rx"] = highlights.replace, -- REPLACE COMP
	["Rv"] = highlights.replace, -- V REPLACE
	["Rvc"] = highlights.replace, -- V REPLACE COMP GENERIC
	["Rvx"] = highlights.replace, -- V REPLACE COMP

	["c"] = highlights.commandline, -- COMMAND
	["cv"] = highlights.commandline, -- VIM EX
	["ce"] = highlights.commandline, -- EX
	["r"] = highlights.commandline, -- PROMPT
	["rm"] = highlights.commandline, -- MORE PROMPT
	["r?"] = highlights.commandline, -- CONFIRM
	["!"] = highlights.commandline, -- SHELL

	["t"] = highlights.terminal, -- TERMINAL
}

local M = {}

M[1] = "mode"

M.icon = "▌"

M.color = function()
	return mode_color[vim.fn.mode()]
end

M.padding = { left = 0, right = 1 }

return M
