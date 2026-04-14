---@param group string Highlight group name
---@param fg string? Foreground color (hex or named)
---@param bg string? Background color (hex or named)
---@param styles string[]? Optional styles (e.g., {"bold", "italic", "underline"})
local function hl(group, fg, bg, styles)
	local opts = {}
	if fg then opts.fg = fg end
	if bg then opts.bg = bg end
	if styles then
		for _, style in ipairs(styles) do
			if style then opts[style] = true end
		end
	end
	vim.api.nvim_set_hl(0, group, opts)
end

return hl
