local Item = require("nougat.item")
local nut_buf_filename = require("nougat.nut.buf.filename")
local nut_buf_filetype = require("nougat.nut.buf.filetype")
local nut_buf_filestatus = require("nougat.nut.buf.filestatus")
local nut_buf_fileencoding = require("nougat.nut.buf.fileencoding")
local nut_buf_fileformat = require("nougat.nut.buf.fileformat")
local get_icon_color = require("nvim-web-devicons").get_icon_color
local get_icon_color_by_filetype = require("nvim-web-devicons").get_icon_color
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local type = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.base },
		prefix = " ",
		suffix = " ",
	}, opts or {})

	return nut_buf_filetype.create(opts)
end

local get_filename_with_icon = function(_, ctx)
	local name, ext = vim.fn.expand("%:p:t"), vim.fn.expand("%:p:e")
	local filetype = vim.api.nvim_get_option_value("filetype", { buf = ctx.bufnr })
	local icon, icon_color = get_icon_color(name, ext)

	if icon == nil then
		icon, icon_color = get_icon_color_by_filetype(filetype)
	end

	return {
		Item({
			content = icon,
			hl = { fg = icon_color },
			cache = {
				scope = "buf",
				clear = "BufFilePost",
			},
		}),
		nut_buf_filename.create({
			prefix = " ",
			config = {
				modifier = ":t",
			},
		}),
	}
end

local name_with_icon = function(opts)
	return Item({
		prefix = opts.prefix or " ",
		suffix = opts.suffix or " ",
		sep_left = opts.sep_left,
		sep_right = opts.sep_right,
		content = get_filename_with_icon,
		cache = {
			scope = "buf",
			clear = "BufFilePost",
		},
	})
end

local status = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.base },
		config = {
			modified = "󰏫 ",
			nomodifiable = "󰏯 ",
			readonly = "󰌾 ",
			sep = " ",
		},
	}, opts or {})

	return nut_buf_filestatus.create(opts)
end

local encoding = function(opts)
	return nut_buf_fileencoding.create(opts)
end

local format = function(opts)
	return nut_buf_fileformat.create(vim.tbl_extend(
		"force",
		{ config = {
			text = {
				unix = " ",
				dos = " ",
				mac = " ",
			},
		} },
		opts or {}
	))
end

return {
	type = type,
	name_with_icon = name_with_icon,
	status = status,
	encoding = encoding,
	format = format,
}
