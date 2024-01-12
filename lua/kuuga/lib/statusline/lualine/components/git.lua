local colors = require("catppuccin.palettes").get_palette("macchiato") or {}
local diff = require("lualine.components.diff"):extend()
local modules = {
	git_diff = require("lualine.components.diff.git_diff"),
}

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
	return nil
end

function diff:init(options)
	diff.super.init(self, options)
	self.highlights.branch = self:create_hl({ fg = "#ff9e64", bg = colors.overlay0, gui = "bold" }, "branch")
	self.highlights.branch_added = self:create_hl({ fg = colors.green, bg = colors.overlay0 }, "branch_added")
	self.highlights.branch_modified = self:create_hl({ fg = colors.blue, bg = colors.overlay0 }, "branch_modified")
	self.highlights.branch_removed = self:create_hl({ fg = colors.red, bg = colors.overlay0 }, "branch_removed")
	self.highlights.added_modified = self:create_hl({ fg = colors.blue, bg = colors.green }, "added_modified")
	self.highlights.modified_removed = self:create_hl({ fg = colors.red, bg = colors.blue }, "modified_removed")
	self.highlights.added_removed = self:create_hl({ fg = colors.red, bg = colors.green }, "added_removed")
end

function diff:update_status(is_focused)
	local hcolors = {}
	for name, highlight_name in pairs(self.highlights) do
		hcolors[name] = self:format_hl(highlight_name)
	end

	local branch = ""
	if type(vim.b.gitsigns_head) == "string" then
		branch = hcolors.branch .. " " .. vim.b.gitsigns_head
	end

	local git_diff = modules.git_diff.get_sign_count((not is_focused and vim.api.nvim_get_current_buf()))
	if git_diff == nil then
		return branch
	end

	local result = {}
	local last = ""
	for _, name in ipairs({ "added", "modified", "removed" }) do
		if git_diff[name] and git_diff[name] > 0 then
			local head = ""
			local tail = hcolors[name] .. " " .. self.options.symbols[name] .. git_diff[name]

			if #result > 0 then
				head = hcolors[last .. "_" .. name] .. head
			else
				head = hcolors["branch_" .. name] .. head
			end

			table.insert(result, head .. tail)
			last = name
		end
	end

	if #result > 0 then
		return branch .. " " .. table.concat(result, " ")
	else
		return branch
	end
end

local M = {}

M[1] = diff

M.colored = true

M.diff_color = {
	added = { fg = colors.surface1, bg = colors.green, gui = "bold" },
	modified = { fg = colors.surface1, bg = colors.blue, gui = "bold" },
	removed = { fg = colors.surface1, bg = colors.red, gui = "bold" },
}

M.symbols = {
	added = " ",
	modified = " ",
	removed = " ",
}

M.separator = { right = "" }

M.source = diff_source

return M
