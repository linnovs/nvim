local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

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
}

local highlights = {
	normal = {
		bg = colors.overlay0,
		fg = colors.teal,
	},
	visual = {
		bg = colors.overlay0,
		fg = colors.peach,
	},
	insert = {
		bg = colors.overlay0,
		fg = colors.green,
	},
	replace = {
		bg = colors.overlay0,
		fg = colors.red,
	},
	commandline = {
		bg = colors.overlay0,
		fg = colors.yellow,
	},
	terminal = {
		bg = colors.overlay0,
		fg = colors.blue,
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

M[1] = function()
	local mode_code = vim.api.nvim_get_mode().mode
	if mode_text[mode_code] == nil then
		return mode_code
	end
	return "▌ " .. mode_text[mode_code]
end

M.color = function()
	return mode_color[vim.fn.mode()]
end

M.padding = { left = 0, right = 1 }

return M
