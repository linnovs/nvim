WinBar = {}

local components = require("kuuga.winbar.components")
local refresh_interval = 16 -- refresh every 16 milliseconds (60fps)

WinBar.last_winbar = { active = {}, inactive = {} } ---@type { active: table<integer, string>, inactive: table<integer, string>}
WinBar.last_refresh_time = {} ---@type table<integer, integer>
WinBar.current_winid = nil ---@type integer

---@param winid integer
function WinBar.refresh(winid)
	local last_refresh_time = WinBar.last_refresh_time[winid] or 0
	if math.abs(last_refresh_time - vim.uv.now()) < refresh_interval then return end

	for _, state in ipairs({ "active", "inactive" }) do
		WinBar.last_winbar[state][winid] = table.concat({
			components.render("filepath", state == "active", false),
			"%=",
			components.render("lsp", state == "active", true),
			components.render("file", state == "active", true),
		})
	end
	WinBar.last_refresh_time[winid] = vim.uv.now()
end

function WinBar.render()
	local active = WinBar.current_winid == vim.api.nvim_get_current_win()
	local winid = vim.api.nvim_get_current_win()
	WinBar.refresh(winid)
	return WinBar.last_winbar[active and "active" or "inactive"][winid] or "%#WinBarNC# 󱢡  Loading ...%*"
end

local disabled_filetypes = { "help", "snacks_dashboard" }

function WinBar.setup()
	WinBar.current_winid = vim.api.nvim_get_current_win()
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(winid)
		local filetype = vim.bo[buf].filetype

		if
			(vim.wo[winid].winbar == "" or WinBar.last_winbar.active[winid] ~= "")
			and not vim.tbl_contains(disabled_filetypes, filetype)
			and vim.api.nvim_win_get_config(winid).relative == ""
		then
			vim.api.nvim_set_option_value("winbar", "%{%v:lua.WinBar.render()%}", { scope = "local", win = winid })
		end
	end
	vim.schedule(function() vim.cmd("redrawstatus!") end)
end
