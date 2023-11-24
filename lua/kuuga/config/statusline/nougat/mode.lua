local nut_mode = require("nougat.nut.mode")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local mode_text = {
	["n"] = "󰚩 󰒘 ", -- NORMAL
	["no"] = "󰚩 󰂪 ", -- OP PENDING
	["nov"] = "󰚩 󰂪 ", -- OP PENDING CHA
	["noV"] = "󰚩 󰂪 ", -- OP PENDING LINE
	["no"] = "󰚩 󰂪 ", -- OP PENDING BLOCK
	["niI"] = "󰚩 󱆠 ", -- INSERT (NORMAL)
	["niR"] = "󰚩 󱆢 ", -- REPLACE (NORMAL)
	["niV"] = "󰚩 󱆣 ", -- V REPLACE (NORMAL)
	["nt"] = "󰚩 󰯄 ", -- TERMINAL NORMAL
	["ntT"] = "󰚩 󱦚 ", -- TERMINAL (NORMAL)

	["v"] = "󱜙 󰕥 ", -- VISUAL
	["vs"] = "󱜙 󰳈 ", -- SELECT (VISUAL)
	["V"] = "󱜙 󰻌 ", -- V-LINE
	["Vs"] = "󱜙 󰻍 ", -- SELECT (V-LINE)
	[""] = "󱜙 󱄻 ", -- V-BLOCK
	["s"] = "󱜙 󱄼 ", -- SELECT (V-BLOCK)

	["s"] = "󱜚 󰳈 ", -- SELECT
	["S"] = "󱜚 󰻍 ", -- S-LINE
	[""] = "󱜚 󱄼 ", -- S-BLOCK

	["i"] = "󱚝 󱢾 ", -- INSERT
	["ic"] = "󱚝 󱢿 ", -- INSERT COMPL GENERIC
	["ix"] = "󱚝 󱢿 ", -- INSERT COMPL

	["R"] = "󱚡 󱢾 ", -- REPLACE
	["Rc"] = "󱚡 󱢿 ", -- REPLACE COMP GENERIC
	["Rx"] = "󱚡 󱢿 ", -- REPLACE COMP
	["Rv"] = "󱚢 󰳈 ", -- V REPLACE
	["Rvc"] = "󱚢 󱢿 ", -- V REPLACE COMP GENERIC
	["Rvx"] = "󱚢 󱢿 ", -- V REPLACE COMP

	["c"] = "󰜍 󱢼 ", -- COMMAND
	["cv"] = "󰜍 󰴳 ", -- VIM EX
	["ce"] = "󰜍 󰴳 ", -- EX
	["r"] = "󰭆 󰚊 ", -- PROMPT
	["rm"] = "󰭆 󰚊 ", -- MORE PROMPT
	["r?"] = "󱨚 󰳈 ", -- CONFIRM
	["!"] = "󱚠 󰦝 ", -- SHELL

	["t"] = "󱇷 󱠨 ", -- TERMINAL

	["-"] = "󱚧 󰦞 ", -- INACTIVE
}

local highlight = {
	normal = {
		bg = color.overlay0,
		fg = color.teal,
	},
	visual = {
		bg = color.overlay0,
		fg = color.peach,
	},
	insert = {
		bg = color.overlay0,
		fg = color.green,
	},
	replace = {
		bg = color.overlay0,
		fg = color.red,
	},
	commandline = {
		bg = color.overlay0,
		fg = color.yellow,
	},
	terminal = {
		bg = color.overlay0,
		fg = color.blue,
	},
	inactive = {
		bg = color.surface0,
		fg = color.overlay0,
	},
}

local mode = function(opts)
	opts = vim.tbl_extend("force", {
		prefix = "▌ ",
		suffix = " ",
		hl = { bold = true },
		config = {
			text = mode_text,
			highlight = highlight,
		},
	}, opts or {})

	return nut_mode.create(opts)
end

return mode
