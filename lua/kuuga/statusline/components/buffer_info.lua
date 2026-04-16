local function selected_lines()
	local lines = math.abs(vim.fn.line("v") - vim.fn.line(".")) + 1

	if lines <= 1 then return "" end

	return table.concat({
		"%#StatusLineBufferInfoSLineIcon#",
		" ",
		"%#StatusLineBufferInfoLine#",
		lines,
		" ",
	})
end

local function selected_chars()
	local words = vim.fn.wordcount()

	if not words.visual_chars then return "" end

	return table.concat({
		"%#StatusLineBufferInfoSCharIcon#",
		"󰘎 ",
		"%#StatusLineBufferInfoLine#",
		words.visual_chars,
		" ",
	})
end

return function(_)
	return table.concat({
		selected_lines(),
		selected_chars(),
		"%#StatusLineBufferInfoIcon#",
		"󰦨 ",
		"%#StatusLineBufferInfoLine#",
		"%L",
	})
end
