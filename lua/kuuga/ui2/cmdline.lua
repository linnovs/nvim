local Cmdline = {}

local api = vim.api
local ui2 = require("vim._core.ui2")
local native_types = {} ---@type string[]
local cmdline_type = nil ---@type string|nil
local cmd_win_saved = nil ---@type table|nil
local original_cmdline_pos = nil

local function get_cmd_win()
	local win = ui2.wins and ui2.wins.cmd
	return (win and api.nvim_win_is_valid(win)) and win or nil
end

local function reposition()
	if not cmdline_type then return end

	local win = get_cmd_win()
	if not win then return end

	if not cmd_win_saved then
		local cfg = api.nvim_win_get_config(win)
		cmd_win_saved = {
			relative = cfg.relative,
			anchor = cfg.anchor,
			col = cfg.col,
			row = cfg.row,
			width = cfg.width,
			border = cfg.border,
		}
		vim.wo[win].winhighlight = "Normal:KuugaUI2CmdlineNormal,FloatBorder:KuugaUI2CmdlineBorder"
	end

	local cols, lines = vim.o.columns, vim.o.lines
	local content_height = math.max(1, api.nvim_win_get_height(win))

	if vim.list_contains(native_types, cmdline_type) then
		pcall(api.nvim_win_set_config, win, {
			relative = "editor",
			col = 0,
			row = math.max(0, lines - content_height),
			width = vim.o.columns,
			border = "none",
		})
		vim.g.ui_cmdline_pos = original_cmdline_pos
		return
	end

	local width = math.max(40, math.min(80, math.floor(cols * 0.6)))
	local col = math.floor((cols - width - 2) * 0.5)
	local row = math.floor((lines - content_height - 2) * 0.1)
	pcall(api.nvim_win_set_config, win, {
		relative = "editor",
		col = col,
		row = row,
		width = width,
		border = "rounded",
		title = "  ",
	})
	vim.g.ui_cmdline_pos = { row + content_height + 2, col + 2 }
end

local wrapped = false
local function wrap_cmdline_show()
	if wrapped then return end

	local cmdline = require("vim._core.ui2.cmdline")
	local orig_cmdline_show = cmdline.cmdline_show
	cmdline.cmdline_show = function(...)
		local rtn = orig_cmdline_show(...)
		if not cmdline_type then return rtn end

		if not vim.list_contains(native_types, cmdline_type) then
			vim._with({ noautocmd = true }, function() vim.opt.cmdheight = 0 end)
		end

		reposition()

		return rtn
	end

	wrapped = true
end

local function wrap_and_reposition()
	wrap_cmdline_show()
	reposition()
end

---@param augroup integer
---@param native_types_param string[]
function Cmdline.setup(augroup, native_types_param)
	native_types = native_types_param
	original_cmdline_pos = vim.g.ui_cmdline_pos

	vim.opt.cmdheight = 0

	api.nvim_set_hl(0, "KuugaUI2CmdlineNormal", { link = "NormalFloat", default = true })
	api.nvim_set_hl(0, "KuugaUI2CmdlineBorder", { link = "FloatBorder", default = true })

	api.nvim_create_autocmd("CmdlineEnter", {
		group = augroup,
		callback = function() cmdline_type = vim.fn.getcmdtype() end,
	})

	api.nvim_create_autocmd("CmdlineLeave", {
		group = augroup,
		callback = function()
			cmdline_type = nil
			vim.g.ui_cmdline_pos = nil
			local win = get_cmd_win()
			if win and cmd_win_saved then pcall(api.nvim_win_set_config, win, cmd_win_saved) end
		end,
	})

	api.nvim_create_autocmd("FileType", {
		group = augroup,
		pattern = "cmd",
		callback = function() vim.schedule(wrap_and_reposition) end,
	})

	api.nvim_create_autocmd({ "VimResized", "TabEnter" }, {
		group = augroup,
		callback = function() vim.schedule(reposition) end,
	})

	vim.schedule(wrap_and_reposition)
end

return Cmdline
