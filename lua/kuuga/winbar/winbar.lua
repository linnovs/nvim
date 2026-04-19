WinBar = {}

local components = require("kuuga.winbar.components")

WinBar.last_winbar = { active = setmetatable({}, { __mode = "k" }), inactive = setmetatable({}, { __mode = "k" }) }

function WinBar.refresh()
	local winid = vim.api.nvim_get_current_win()
	if not vim.api.nvim_win_is_valid(winid) then return end
	for _, state in ipairs({ "active", "inactive" }) do
		WinBar.last_winbar[state][winid] = table.concat({
			components.render("filepath", state == "active", false),
			components.render("search_count", state == "active", true),
			"%=",
			components.render("grammar", state == "active", true),
			components.render("copilot", state == "active", true),
			components.render("lsp", state == "active", true),
			components.render("file", state == "active", true),
		})
	end
end

function WinBar.render()
	local winid = vim.api.nvim_get_current_win()
	local active = tonumber(vim.g.actual_curwin) == winid
	return WinBar.last_winbar[active and "active" or "inactive"][winid] or "%#WinBarNC# 󱢡  Loading ...%*"
end
