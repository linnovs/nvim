local vi_mode = require("feline.providers.vi_mode")

local api = vim.api
local fn = vim.fn

local blank_sep = { str = " ", hl = { bg = "file_bg" } }
local left_sep = { { str = "left", hl = { fg = "file_fg", bg = "file_bg" } }, blank_sep }

local M = {}

M.info = {
	provider = {
		name = "file_info",
		opts = {
			type = "unique_short",
			file_modified_icon = "",
		},
	},
	icon = function(winid)
		local filename = api.nvim_buf_get_name(api.nvim_win_get_buf(winid))
		local extension = fn.fnamemodify(filename, ":e")

		local icon = { str = "", hl = {} }
		local hlname

		icon.str, hlname = require("nvim-web-devicons").get_icon(filename, extension, { default = true })
		local fg = api.nvim_get_hl_by_name(hlname, true).foreground

		if fg then
			icon.hl.fg = string.format("#%06x", fg)
		end

		return icon
	end,
	left_sep = " ",
	right_sep = " ",
}

M.encoding = {
	provider = "file_encoding",
	hl = {
		fg = "file_fg",
		bg = "file_bg",
		style = "bold",
	},
	right_sep = blank_sep,
	left_sep = blank_sep,
}

M.format = {
	provider = function()
		local os = vim.bo.fileformat:upper()
		local icon = { ["UNIX"] = " ", ["MAC"] = " ", ["DOS"] = " " }
		return icon[os] .. os
	end,
	hl = {
		fg = "file_fg",
		bg = "file_bg",
		style = "bold",
	},
	right_sep = blank_sep,
	left_sep = left_sep,
}

M.type = {
	provider = "file_type",
	hl = {
		fg = "file_fg",
		bg = "file_bg",
		style = "bold",
	},
	right_sep = blank_sep,
	left_sep = left_sep,
	icon = function(winid)
		local filename = api.nvim_buf_get_name(api.nvim_win_get_buf(winid))
		local extension = fn.fnamemodify(filename, ":e")

		local icon, fg = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })

		return {
			str = icon .. " ",
			hl = {
				fg = fg,
			},
		}
	end,
}

M.position = {
	provider = "position",
	hl = vi_mode.get_mode_highlight_name,
}

M.position_inactive = {
	provider = "position",
}

return M
