---@diagnostic disable: undefined-field
local Item = require("nougat.item")
local create_cache_store = require("nougat.cache").create_store
local Store = require("nougat.store").TabStore
local sep = require("nougat.separator")
local status = require("noice.api.status")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local cache_store = Store("kuuga.nougat.nut.macro", {
	msg = "",
})

local get_cache = function(store)
	local tab_id = vim.api.nvim_tabpage_get_number(0)
	return store[tab_id]
end

local get_content = function(item, ctx)
	local cache = item:cache(ctx)
	cache.msg = status.mode.get()

	if string.sub(cache.msg, 1, 9) == "recording" then
		return string.sub(cache.msg, 11)
	end
end

local is_hidden = function(_, _)
	return not status.mode.has()
end

local marco = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { fg = color.red, bg = color.overlay0 },
		hidden = is_hidden,
		prefix = "󰻃 ",
		content = get_content,
		suffix = " ",
		cache = {
			store = cache_store,
			get = get_cache,
		},
	}, opts or {})

	return Item(opts)
end

return marco
