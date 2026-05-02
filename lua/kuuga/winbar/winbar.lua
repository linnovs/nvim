local M = {}

local components = require("kuuga.winbar.components")

M.last_winbar = { active = setmetatable({}, { __mode = "k" }), inactive = setmetatable({}, { __mode = "k" }) }

function M.refresh()
	local winid = vim.api.nvim_get_current_win()
	if not vim.api.nvim_win_is_valid(winid) then return end
	for _, state in ipairs({ "active", "inactive" }) do
		local is_active = state == "active"
		M.last_winbar[state][winid] = table.concat({
			components.render("winnr", is_active, false),
			components.render("filepath", is_active, true),
			components.render("search_count", is_active, true),
			components.render("filestatus", is_active, true),
			"%=",
			components.render("grammar", is_active, true),
			components.render("copilot", is_active, true),
			components.render("lsp", is_active, true),
			components.render("file", is_active, true),
		})
	end
end

function M.render()
	local winid = vim.g.statusline_winid
	local state = winid == vim.api.nvim_get_current_win() and "active" or "inactive"
	return M.last_winbar[state][winid] or "%#WinBarNC# 󱢡  Loading ...%*"
end

return M
